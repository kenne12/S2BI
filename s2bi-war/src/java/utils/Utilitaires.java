package utils;

import entities.Budget;
import entities.Ciblerealisation;
import entities.Couverturepopulation;
import entities.Financement;
import entities.Financementbudget;
import entities.Mouchard;
import entities.Sousperiodecosting;
import entities.Uniteorganisation;
import entities.Utilisateur;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;
import javax.transaction.UserTransaction;
import org.joda.time.DateTime;
import org.joda.time.Days;
import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.UploadedFile;
import sessions.BudgetFacadeLocal;
import sessions.CiblerealisationFacadeLocal;
import sessions.CouverturepopulationFacadeLocal;
import sessions.FinancementFacadeLocal;
import sessions.FinancementbudgetFacadeLocal;
import sessions.MouchardFacadeLocal;

public class Utilitaires {

    private static final ServletContext servletContext = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
    public static final String path = servletContext.getRealPath("");
    public static final String repertoireParDefaultNotesTrim = "rapport/notes/trimestriel";
    public static final String chemin = servletContext.getContextPath();

    public static void saveOperation(MouchardFacadeLocal mouchardFacadeLocal, String action, Utilisateur utilisateur) {
        try {
            Mouchard mouchard = new Mouchard();
            mouchard.setIdmouchard(mouchardFacadeLocal.nextVal());
            mouchard.setAction(action);
            mouchard.setIdutilisateur(utilisateur);
            mouchard.setDateAction(new Date());
            mouchard.setHeure(new Date());
            mouchardFacadeLocal.create(mouchard);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getExtension(String nomFichier) {
        int taille = nomFichier.length();
        String extension = "";
        for (int i = 0; i < taille; i++) {
            if (nomFichier.charAt(i) == '.') {
                extension = "";
            } else {
                extension = extension + nomFichier.charAt(i);
            }
        }
        return extension;
    }

    public static boolean estExtensionImage(String extension) {
        if ((extension == null) || (extension.equals(""))) {
            return false;
        }
        String ext = extension.toUpperCase();
        if (ext.equals("JPG")) {
            return true;
        }
        if (ext.equals("JPEG")) {
            return true;
        }
        if (ext.equals("GIF")) {
            return true;
        }
        if (ext.equals("PNG")) {
            return true;
        }
        if (ext.equals("BMP")) {
            return true;
        }
        return false;
    }

    public static boolean estFichierImage(String nom) {
        String extension = getExtension(nom);
        if ((extension == null) || (extension.equals(""))) {
            return false;
        }
        String ext = extension.toUpperCase();
        if (ext.equals("JPG")) {
            return true;
        }
        if (ext.equals("JPEG")) {
            return true;
        }
        if (ext.equals("GIF")) {
            return true;
        }
        if (ext.equals("PNG")) {
            return true;
        }
        if (ext.equals("BMP")) {
            return true;
        }
        return false;
    }

    public static boolean handleFileUpload(FileUploadEvent event, String absoluteSavePath) {
        try {
            OutputStream saveFile = new FileOutputStream(new File(absoluteSavePath));
            InputStream in = event.getFile().getInputstream();
            byte[] buff = new byte[8];
            int n;
            while ((n = in.read(buff)) >= 0) {
                saveFile.write(buff);
                buff = new byte[8];
            }
        } catch (IOException ex) {
            FacesMessage message = new FacesMessage("Error", "Error While uploading " + event.getFile().getFileName());
            FacesContext.getCurrentInstance().addMessage(null, message);
            Logger.getLogger(Utilitaires.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        OutputStream saveFile;
        return true;
    }

    public static boolean handleFileUpload(UploadedFile file, String absoluteSavePath) {
        try {
            OutputStream saveFile = new FileOutputStream(new File(absoluteSavePath));
            InputStream in = file.getInputstream();
            byte[] buff = new byte[8];
            int n;
            while ((n = in.read(buff)) >= 0) {
                saveFile.write(buff);
                buff = new byte[8];
            }
        } catch (IOException ex) {
            FacesMessage message = new FacesMessage("Error", "Error While uploading " + file.getFileName());
            FacesContext.getCurrentInstance().addMessage(null, message);
            Logger.getLogger(Utilitaires.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        OutputStream saveFile;
        return true;
    }

    public static boolean CopierFichier(File Source, File Destination) {
        boolean resultat = false;

        FileInputStream filesource = null;
        FileOutputStream fileDestination = null;
        try {
            filesource = new FileInputStream(Source);
            fileDestination = new FileOutputStream(Destination);
            byte[] buffer = new byte[1000];
            int nblecture;
            while ((nblecture = filesource.read(buffer)) != -1) {
                fileDestination.write(buffer, 0, nblecture);
                buffer = new byte[8];
            }
            resultat = true;
        } catch (FileNotFoundException nf) {
            nf.printStackTrace();
        } catch (IOException io) {
            io.printStackTrace();
        } finally {
            try {
                filesource.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                fileDestination.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return resultat;
    }

    public static Double arrondiNDecimales(double x, int n) {
        double pow = Math.pow(10.0D, n);
        return Double.valueOf(Math.floor(x * pow) / pow);
    }

    public static String formatPrenomMaj(String prenom) {
        if (prenom.isEmpty()) {
            return " ";
        }
        char prenLettre = '0';
        prenLettre = prenom.charAt(0);

        String leReste = prenom.substring(1, prenom.length());

        String lettre1 = String.valueOf(prenLettre);

        leReste = leReste.toLowerCase();

        return lettre1.toUpperCase() + leReste;
    }

    public static Integer duration(Date date1, Date date2) {
        DateTime dateDebut = new DateTime("" + (date1.getYear() + 1900) + "-" + (date1.getMonth() + 1) + "-" + date1.getDate() + "");
        DateTime dateFin = new DateTime("" + (date2.getYear() + 1900) + "-" + (date2.getMonth() + 1) + "-" + date2.getDate() + "");

        Integer nbjr = Integer.valueOf(Days.daysBetween(dateDebut, dateFin).getDays());
        return nbjr;
    }

    public static boolean isAccess(Long menu) {
        if (SessionMBean.getAccess().isEmpty()) {
            return false;
        } else {
            if (SessionMBean.getAccess().contains(1L)) {
                return true;
            } else {
                if (SessionMBean.getAccess().contains(menu)) {
                    return true;
                } else {
                    return false;
                }
            }
        }
    }

    public static void generate(UserTransaction ut,
            Uniteorganisation uniteorganisation,
            List<Sousperiodecosting> sousperiodecostings,
            BudgetFacadeLocal budgetFacadeLocal,
            CiblerealisationFacadeLocal ciblerealisationFacadeLocal,
            CouverturepopulationFacadeLocal couverturepopulationFacadeLocal,
            Sousperiodecosting sousperiodecosting,
            FinancementFacadeLocal financementFacadeLocal,
            FinancementbudgetFacadeLocal financementbudgetFacadeLocal) {
        try {

            ut.begin();
            for (Sousperiodecosting spc : sousperiodecostings) {

                Double budget_periode = 0d;
                List<Budget> bTemps = budgetFacadeLocal.findByUniteSousPeriodecosting(uniteorganisation.getIduniteorganisation(), spc.getIdsousperiode());
                if (!bTemps.isEmpty()) {
                    for (Budget ligne : bTemps) {

                        Budget b = ligne;

                        List<Ciblerealisation> cTemp = ciblerealisationFacadeLocal.findByUnitePeriodeIndicateur(uniteorganisation.getIduniteorganisation(), spc.getIdsousperiode(), ligne.getIdindicateur().getIdindicateur());
                        double cible = 0d;
                        double cu = 0d;
                        double couverture = 0d;
                        if (!cTemp.isEmpty()) {
                            cible = cTemp.get(0).getValeurcible();
                            cu = cTemp.get(0).getCoutUnitaire();
                            couverture = cTemp.get(0).getCouverture();
                        }

                        Couverturepopulation cpTemps = couverturepopulationFacadeLocal.findBySousPeriodeCostingUnite(spc.getIdsousperiode(), uniteorganisation.getIduniteorganisation());

                        double scoreEquite = 0;
                        double scoreQualite = 0d;
                        double majoration = 0d;
                        double baq = 0;
                        if (cpTemps != null) {
                            scoreEquite = cpTemps.getValScoreEquite();
                            majoration = cpTemps.getMajoration();
                            baq = cpTemps.getBaq();
                            scoreQualite = cpTemps.getValScoreQualite();
                        }

                        Double total1 = cible * cu * (couverture / 100);
                        Double bonusEquite = total1 * (scoreEquite / 100);
                        Double total2 = total1 + bonusEquite;
                        Double bonusQualite = total2 * (scoreQualite / 100) * (majoration / 100);

                        Double total = total2 + bonusQualite + baq;

                        b.setBonusequite(bonusEquite);
                        b.setBonusqualite(bonusQualite);
                        b.setTotal1(total1);
                        b.setTotal2(total2);
                        b.setTotal(total);
                        b.setBaq(baq);

                        budget_periode += total;

                        budgetFacadeLocal.edit(b);

                        if (!cTemp.isEmpty()) {
                            Ciblerealisation cr = cTemp.get(0);
                            cr.setBonusEquite(bonusEquite);
                            cr.setBonusQualite(bonusQualite);
                            cr.setTotal1(total1);
                            cr.setTotal2(total2);
                            cr.setBudget(total);
                            ciblerealisationFacadeLocal.edit(cr);
                        }
                    }
                }

                if (budget_periode > 0D) {
                    List<Financement> financements = financementFacadeLocal.findBySousPeriode(spc.getIdsousperiode());
                    for (Financement f : financements) {
                        if (f.getPourcentage() != null && f.getPourcentage() != 0d) {
                            Financementbudget fb = financementbudgetFacadeLocal.findByBailleurTypeUoSousperiode(f.getIdbailleurfond().getIdbailleurfond(), f.getIdtypeuniteorganisation().getIdtypeuniteorganisation(), f.getIdsousPeriode().getIdsousperiode());
                            if (fb != null) {
                                fb.setPourcentage(f.getPourcentage());
                                fb.setBudget(budget_periode);                                
                                fb.setFinancement((budget_periode * f.getPourcentage()) / 100);
                                financementbudgetFacadeLocal.edit(fb);
                            } else {
                                fb = new Financementbudget();
                                fb.setIdfinancementbudget(financementbudgetFacadeLocal.nextVal());
                                fb.setIdbailleurfond(f.getIdbailleurfond());
                                fb.setIdtypeUo(f.getIdtypeuniteorganisation());
                                fb.setIdsousPeriode(f.getIdsousPeriode());
                                fb.setIdperiode(fb.getIdperiode());
                                fb.setPourcentage(f.getPourcentage());
                                fb.setBudget(budget_periode);
                                fb.setFinancement((budget_periode * f.getPourcentage()) / 100);
                                financementbudgetFacadeLocal.create(fb);
                            }
                        }
                    }
                }
            }

            ut.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
