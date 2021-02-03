/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.baq;

import entities.Couverturepopulation;
import entities.Lignebaq;
import entities.Sousperiodecosting;
import entities.TypeBaq;
import entities.Uniteorganisation;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import org.primefaces.context.RequestContext;
import utils.JsfUtil;
import utils.SessionMBean;
import utils.Utilitaires;

/**
 *
 * @author kenne
 */
@ManagedBean
@SessionScoped
public class BaqController extends AbstractBaqController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public BaqController() {
    }

    @PostConstruct
    private void init() {
        couverturepopulation = new Couverturepopulation();
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(40L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            enabledSelect = false;

            selectedBaqs.clear();
            couverturepopulations.clear();

            couverturepopulation = new Couverturepopulation();
            sousperiodecosting = new Sousperiodecosting();
            uniteorganisation = new Uniteorganisation();
            periodecosting = SessionMBean.getPeriodeCosting();
            uniteorganisation.setIduniteorganisation(0);

            renderedCible = true;
            renderedPas = false;

            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (lignebaq != null) {
                if (!Utilitaires.isAccess(40L)) {
                    signalError("acces_refuse");
                    return;
                }

                mode = "Edit";
                enabledSelect = true;

                RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').show()");
            } else {
                signalError("not_selected_row");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void updateRenderedColumn() {
        renderedCible = true;
        renderedPas = false;
    }

    public void generate() {
        try {
            if (modeProjection == 0) {
                signalError("choisir_mode_generation");
                return;
            }

            ut.begin();

            for (Lignebaq lbaq : selectedBaqs) {

                int i = 0;
                for (Couverturepopulation cp : couverturepopulations) {

                    List<Lignebaq> lbaqTemps = lignebaqFacadeLocal.findByCouvertureRubrique(cp.getIdcouverturepopulation(), lbaq.getIdTypeBaq().getIdTypeBaq());

                    if (modeProjection == 1) {
                        if (lbaqTemps.isEmpty()) {

                            Lignebaq l = new Lignebaq();

                            l.setIdLignebaq(lignebaqFacadeLocal.nextVal());
                            l.setIdcouverture(cp);

                            l.setIdTypeBaq(lbaq.getIdTypeBaq());
                            l.setIdsousPeriode(cp.getIdsousperiode().getIdsousperiode());

                            //Quantité
                            Double pasQte = ((lbaq.getQteFin() - lbaq.getQteDebut()) / (couverturepopulations.size() - 1));
                            l.setQtePas(pasQte);

                            l.setQteDebut(lbaq.getQteDebut());
                            l.setQteFin(lbaq.getQteFin());
                            l.setQuantite(lbaq.getQteDebut() + (i * pasQte));

                            if (lbaq.getQteFin() < lbaq.getQteDebut()) {
                                l.setQuantite(lbaq.getQteFin());
                                l.setQtePas(0d);
                                l.setQteFin(lbaq.getQteFin());
                            }

                            if (l.getQtePas() < 0d) {
                                l.setQtePas(0D);
                            }

                            //Cout unitaire
                            Double pasCu = ((lbaq.getCuFin() - lbaq.getCuDebut()) / (couverturepopulations.size() - 1));
                            l.setCuPas(pasCu);

                            l.setCuDebut(lbaq.getCuDebut());
                            l.setCuFin(lbaq.getCuFin());
                            l.setCoutUnitaire(lbaq.getCuDebut() + (i * pasCu));

                            if (lbaq.getCuFin() < lbaq.getCuDebut()) {
                                l.setCoutUnitaire(lbaq.getCuFin());
                                l.setCuPas(0d);
                                l.setCuFin(lbaq.getCuFin());
                            }

                            if (l.getCuPas() < 0d) {
                                l.setCuPas(0D);
                            }

                            l.setTotal((l.getCoutUnitaire() * l.getQuantite()));
                            lignebaqFacadeLocal.create(l);

                        } else {
                            Lignebaq l = lbaqTemps.get(0);

                            //Quantité
                            if (lbaq.getQteFin() >= lbaq.getQteDebut()) {
                                Double pasQte = ((lbaq.getQteFin() - lbaq.getQteDebut()) / (couverturepopulations.size() - 1));
                                l.setQuantite(lbaq.getQteDebut() + (i * pasQte));
                                l.setQtePas(pasQte);
                                if (l.getQtePas() < 0d) {
                                    l.setQtePas(0d);
                                }
                                l.setQteFin(lbaq.getQteFin());
                                l.setQteDebut(lbaq.getQteDebut());
                            } else {
                                l.setQuantite(lbaq.getQteFin());
                                l.setQteFin(lbaq.getQteFin());
                                l.setQteDebut(lbaq.getQteDebut());
                                l.setQtePas(0d);
                            }

                            //Cout unitaire
                            if (lbaq.getCuFin() >= lbaq.getCuDebut()) {
                                Double pasCu = ((lbaq.getCuFin() - lbaq.getCuDebut()) / (couverturepopulations.size() - 1));
                                l.setCoutUnitaire(lbaq.getCuDebut() + (i * pasCu));
                                l.setCuPas(pasCu);
                                if (l.getCuPas() < 0d) {
                                    l.setCuPas(0d);
                                }
                                l.setCuFin(lbaq.getCuFin());
                                l.setCuDebut(lbaq.getCuDebut());
                            } else {
                                l.setCoutUnitaire(lbaq.getCuFin());
                                l.setCuFin(lbaq.getCuFin());
                                l.setCuDebut(lbaq.getCuDebut());
                                l.setCuPas(0d);
                            }
                            l.setTotal(l.getCoutUnitaire() * l.getQuantite());
                            lignebaqFacadeLocal.edit(l);
                        }
                    }
                    i += 1;
                }
            }

            int conteur = 0;
            for (Couverturepopulation cp : couverturepopulations) {
                List<Lignebaq> lTemps = lignebaqFacadeLocal.findByCouverture(cp.getIdcouverturepopulation());
                Double baq = 0d;
                for (Lignebaq l : lTemps) {
                    baq += l.getTotal();
                }
                cp.setBaq(baq);
                couverturepopulations.get(conteur).setBaq(baq);
                couverturepopulationFacadeLocal.edit(cp);
                conteur++;
            }
            ut.commit();

            List<Sousperiodecosting> spcs = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);
            Utilitaires.generate(ut, uniteorganisation, spcs, budgetFacadeLocal, ciblerealisationFacadeLocal, couverturepopulationFacadeLocal, sousperiodecosting, financementFacadeLocal, financementbudgetFacadeLocal);

            signalSuccess();
        } catch (Exception e) {
            e.printStackTrace();
            signalException(e);
        }
    }

    public String loadValue(Couverturepopulation cp, TypeBaq typeBaq) {
        String resultat = "";
        Double qte = 0d;
        Double cu = 0d;
        try {
            List<Lignebaq> lbTemps = lignebaqFacadeLocal.findByCouvertureRubrique(cp.getIdcouverturepopulation(), typeBaq.getIdTypeBaq());
            if (!lbTemps.isEmpty()) {
                qte = lbTemps.get(0).getQuantite();
                cu = lbTemps.get(0).getCoutUnitaire();
                resultat = "" + JsfUtil.formaterStringMoney(cu.intValue()) + " / " + JsfUtil.formaterStringMoney(qte);
                return resultat;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String formatStingMoney(Double value) {
        if (value == null) {
            return "";
        }
        return JsfUtil.formaterStringMoney(value);
    }

    public void updateData() {
        try {
            selectedBaqs.clear();
            if (periodecosting.getIdperiodecosting() != 0) {
                if (uniteorganisation.getIduniteorganisation() != 0) {

                    couverturepopulations = couverturepopulationFacadeLocal.findByPeriodeCostingUnite(periodecosting.getIdperiodecosting(), uniteorganisation.getIduniteorganisation());
                    sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCosting(periodecosting.getIdperiodecosting());

                    List<Lignebaq> ligneBaqTemps = lignebaqFacadeLocal.findByPerioCostingUniteBase(periodecosting.getIdperiodecosting(), uniteorganisation.getIduniteorganisation());

                    if (!couverturepopulations.isEmpty()) {

                        for (Couverturepopulation cps : couverturepopulations) {
                            if (cps.getIdsousperiode().getPeriodedebut()) {
                                couverturepopulation = cps;
                                break;
                            }
                        }

                        if (!ligneBaqTemps.isEmpty() && ligneBaqTemps != null) {
                            selectedBaqs.addAll(ligneBaqTemps);
                        } else {
                            List<TypeBaq> tbTemp = typeBaqFacadeLocal.findAllRangeCode();
                            for (TypeBaq t : tbTemp) {
                                Lignebaq lb = new Lignebaq();
                                lb.setIdLignebaq(0L);
                                lb.setIdTypeBaq(t);
                                lb.setIdcouverture(couverturepopulation);
                                lb.setCoutUnitaire(0D);
                                lb.setCuDebut(0D);
                                lb.setCuFin(0d);
                                lb.setCuPas(0d);

                                lb.setQuantite(0d);
                                lb.setQteDebut(0d);
                                lb.setQteFin(0d);
                                lb.setQtePas(0d);

                                selectedBaqs.add(lb);
                            }
                        }
                    }
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void create() {
        try {

        } catch (Exception e) {
            signalException(e);
        }
    }

    public void signalError(String chaine) {
        RequestContext.getCurrentInstance().execute("PF('AjaxNotifyDialog').hide()");
        routine.feedBack("information", "/resources/tool_images/warning.jpeg", routine.localizeMessage(chaine));
        RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
    }

    public void signalSuccess() {
        RequestContext.getCurrentInstance().execute("PF('AjaxNotifyDialog').hide()");
        routine.feedBack("information", "/resources/tool_images/success.png", routine.localizeMessage("operation_reussie"));
        RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
    }

    public void signalException(Exception e) {
        RequestContext.getCurrentInstance().execute("PF('AjaxNotifyDialog').hide()");
        routine.catchException(e, routine.localizeMessage("erreur_execution"));
        RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
    }
}
