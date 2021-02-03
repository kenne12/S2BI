/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.projectioncible;

import entities.Ciblerealisation;
import entities.Couverturepopulation;
import entities.Indicateur;
import entities.Sousperiodecosting;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import org.primefaces.context.RequestContext;
import utils.SessionMBean;
import utils.Utilitaires;

/**
 *
 * @author kenne
 */
@ManagedBean
@SessionScoped
public class ProjectionCibleController extends AbstractProjectionCibleController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public ProjectionCibleController() {
    }

    @PostConstruct
    private void init() {
        couverturepopulation = new Couverturepopulation();
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(36L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            enabledSelect = false;
            selectedCrs.clear();

            couverturepopulation = new Couverturepopulation();
            sousperiodecosting = new Sousperiodecosting();
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
            if (ciblerealisation != null) {

                if (!Utilitaires.isAccess(36L)) {
                    signalError("acces_refuse");
                    return;
                }

                ciblerealisations.clear();
                List<Ciblerealisation> crTemps = ciblerealisationFacadeLocal.findByUnitePeriodePeriode(ciblerealisation.getIduniteorganisation().getIduniteorganisation(),
                        ciblerealisation.getIdsousperiode().getIdperiodecosting().getIdperiodecosting(),
                        ciblerealisation.getIdindicateur().getIdindicateur());

                for (Ciblerealisation cr : crTemps) {
                    if (!cr.getIdsousperiode().getPeriodedebut()) {
                        ciblerealisations.add(cr);
                    }
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

            for (Ciblerealisation cr : selectedCrs) {

                int i = 1;
                for (Sousperiodecosting sp : sousperiodecostings) {

                    List<Ciblerealisation> crTemps = ciblerealisationFacadeLocal.findByUnitePeriodeIndicateur(cr.getIduniteorganisation().getIduniteorganisation(), sp.getIdsousperiode(), cr.getIdindicateur().getIdindicateur());

                    if (modeProjection == 1) {
                        if (crTemps.isEmpty()) {

                            Ciblerealisation c = new Ciblerealisation();
                            c.setIdciblerealisation(ciblerealisationFacadeLocal.nextVal());
                            c.setIdindicateur(cr.getIdindicateur());
                            c.setIdperiode(sp.getIdperiode());
                            c.setIdsousperiode(sp);
                            c.setIduniteorganisation(cr.getIduniteorganisation());

                            c.setCUnitaireDebut(0d);
                            c.setCUnitaireFin(0d);
                            c.setCoutUnitaire(0d);
                            c.setPasCoutUnitaire(0d);

                            c.setCouverture(0d);
                            c.setValeurrealisee(0d);

                            c.setTotal1(0d);
                            c.setTotal2(0d);
                            c.setBonusEquite(0d);
                            c.setBonusQualite(0d);
                            c.setBaq(0d);
                            c.setBudget(0d);

                            Double pas = ((cr.getValCibleFin() - cr.getValeurcible()) / (sousperiodecostings.size()));
                            c.setValeurcible(cr.getValeurcible() + (i * pas));
                            c.setPasValCible(pas);
                            c.setValCibleFin(cr.getValCibleFin());
                            //on met à jour le pas

                            if (cr.getValCibleFin() < cr.getValeurcible()) {
                                c.setValeurcible(cr.getValCibleFin());
                                c.setPasValCible(0d);
                                c.setValCibleFin(cr.getValCibleFin());
                            }

                            if (c.getPasValCible() < 0d) {
                                c.setPasValCible(0d);
                            }
                            cr.setPasValCible(c.getPasValCible());
                            ciblerealisationFacadeLocal.create(c);
                        } else {
                            Ciblerealisation c = crTemps.get(0);
                            if (cr.getValCibleFin() >= cr.getValeurcible()) {
                                Double pas = ((cr.getValCibleFin() - cr.getValeurcible()) / (sousperiodecostings.size()));
                                c.setValeurcible(cr.getValeurcible() + (i * pas));
                                c.setPasValCible(pas);
                                if (c.getPasValCible() < 0d) {
                                    c.setPasValCible(0d);
                                }

                                //on met à jour le pas
                                cr.setPasValCible(c.getPasValCible());
                                c.setValCibleFin(cr.getValCibleFin());

                                if (c.getCouverture() != 0) {
                                    Double vr = (c.getCouverture() * c.getValeurcible()) / 100;
                                    c.setValeurrealisee(vr);
                                }
                            }
                            ciblerealisationFacadeLocal.edit(c);
                        }
                    }
                    i += 1;
                }
                ciblerealisationFacadeLocal.edit(cr);
            }
            ut.commit();
            Utilitaires.generate(ut, uniteorganisation, sousperiodecostings, budgetFacadeLocal, ciblerealisationFacadeLocal, couverturepopulationFacadeLocal, sousperiodecosting, financementFacadeLocal, financementbudgetFacadeLocal);

            signalSuccess();
        } catch (Exception e) {
            e.printStackTrace();
            signalException(e);
        }
    }

    public void edit() {
        try {
            for (Ciblerealisation cr : ciblerealisations) {
                ciblerealisationFacadeLocal.edit(cr);
            }
            signalSuccess();
            RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').hide()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public Ciblerealisation loadValue(Ciblerealisation cr, Sousperiodecosting spc) {
        Ciblerealisation result = new Ciblerealisation();
        try {
            List<Ciblerealisation> crTemps = ciblerealisationFacadeLocal.findByUnitePeriodeIndicateur(cr.getIduniteorganisation().getIduniteorganisation(), spc.getIdsousperiode(), cr.getIdindicateur().getIdindicateur());
            if (!crTemps.isEmpty()) {
                result = crTemps.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new Ciblerealisation();
        }
        return result;
    }

    public void updateData() {
        try {
            selectedCrs.clear();
            if (periodecosting.getIdperiodecosting() != 0) {
                if (uniteorganisation.getIduniteorganisation() != 0) {

                    sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);

                    List<Couverturepopulation> cps = couverturepopulationFacadeLocal.findByPeriodeCostingUnite(periodecosting.getIdperiodecosting(), uniteorganisation.getIduniteorganisation());
                    List<Sousperiodecosting> spc = sousperiodecostingFacadeLocal.findByPeriodeCosting(periodecosting.getIdperiodecosting());

                    for (Sousperiodecosting temp : spc) {
                        if (temp.getPeriodedebut()) {
                            this.sousperiodecosting = temp;
                            break;
                        }
                    }

                    for (Couverturepopulation temp : cps) {
                        if (temp.getIdperiode().equals(sousperiodecosting.getIdperiode())) {
                            this.couverturepopulation = temp;
                            break;
                        }
                    }

                    List<Ciblerealisation> crTemps = ciblerealisationFacadeLocal.findByUniteSousPeriode(uniteorganisation.getIduniteorganisation(), sousperiodecosting.getIdsousperiode());

                    if (!crTemps.isEmpty() && crTemps != null) {
                        selectedCrs.addAll(crTemps);
                    } else {
                        List<Indicateur> indTemp = indicateurFacadeLocal.findAllRange();
                        for (Indicateur i : indTemp) {
                            Ciblerealisation cr = new Ciblerealisation();
                            cr.setIdciblerealisation(0L);
                            cr.setIdindicateur(i);
                            cr.setIduniteorganisation(uniteorganisation);
                            cr.setIdperiode(sousperiodecosting.getIdperiode());
                            cr.setIdsousperiode(sousperiodecosting);
                            cr.setCouverture(0d);
                            cr.setValeurrealisee(0d);

                            cr.setCUnitaireDebut(0d);
                            cr.setCoutUnitaire(0d);
                            cr.setCUnitaireFin(0d);
                            cr.setPasCoutUnitaire(0d);

                            double coef = sousperiodecosting.getIdperiode().getIdtypePeriode().getCoefMultiplicateur();
                            double valeur = Math.round((i.getCibleAnnuelle() / coef) * couverturepopulation.getValeur());
                            cr.setValeurcible(Utilitaires.arrondiNDecimales(valeur, 2));
                            selectedCrs.add(cr);
                        }
                    }
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCalcul(int index) {
        try {
            Ciblerealisation cr = selectedCrs.get(index);
            double valeur = (cr.getValeurrealisee() / cr.getValeurcible()) * 100;
            selectedCrs.get(index).setCouverture(Math.rint(valeur));
        } catch (Exception e) {
            selectedCrs.get(index).setCouverture(0d);
        }
    }

    public void delete() {
        try {
            if (ciblerealisation != null) {
                if (!Utilitaires.isAccess(12L)) {
                    signalError("acces_refuse");
                    return;
                }
                signalSuccess();
            } else {
                signalError("not_row_selected");
            }
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
