/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.cible_autre;

import entities.Budget;
import entities.Ciblerealisation;
import entities.Couverturepopulation;
import entities.Sousperiodecosting;
import entities.TypestructureIndicateur;
import entities.Uniteorganisation;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.context.RequestContext;
import utils.SessionMBean;
import utils.Utilitaires;

/**
 *
 * @author kenne
 */
@ManagedBean
@ViewScoped
public class CibleAutreController extends AbstractCibleAutreController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public CibleAutreController() {
    }

    @PostConstruct
    private void init() {
        couverturepopulation = new Couverturepopulation();
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(33L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            enabledSelect = false;
            selectedCrs.clear();

            couverturepopulation = new Couverturepopulation();
            sousperiodecosting = new Sousperiodecosting();
            uniteorganisation = new Uniteorganisation();
            periodecosting = SessionMBean.getPeriodeCosting();
            uniteorganisation.setIduniteorganisation(0);

            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (couverturepopulation != null) {
                if (!Utilitaires.isAccess(33L)) {
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

    public void updateData() {
        try {
            selectedCrs.clear();
            couverturepopulation = new Couverturepopulation();
            sousperiodecosting = new Sousperiodecosting();
            if (periodecosting.getIdperiodecosting() != 0) {
                if (uniteorganisation.getIduniteorganisation() != 0) {

                    uniteorganisation = uniteorganisationFacadeLocal.find(uniteorganisation.getIduniteorganisation());

                    List<Sousperiodecosting> spc = sousperiodecostingFacadeLocal.findByPeriodeCosting(periodecosting.getIdperiodecosting());
                    for (Sousperiodecosting temp : spc) {
                        if (temp.getPeriodedebut()) {
                            this.sousperiodecosting = temp;
                            break;
                        }
                    }

                    List<Ciblerealisation> crTemps = ciblerealisationFacadeLocal.findByUniteSousPeriode(uniteorganisation.getIduniteorganisation(), sousperiodecosting.getIdsousperiode());

                    if (!crTemps.isEmpty()) {
                        selectedCrs.addAll(crTemps);
                    } else {
                        List<TypestructureIndicateur> indTemp = typestructureIndicateurFacadeLocal.findByTypeUo(uniteorganisation.getIdtypeuniteorganisation().getIdtypeuniteorganisation());
                        if (!indTemp.isEmpty()) {
                            for (TypestructureIndicateur i : indTemp) {
                                Ciblerealisation cr = new Ciblerealisation();
                                cr.setIdciblerealisation(0L);
                                cr.setIdindicateur(i.getIdindicateur());
                                cr.setIduniteorganisation(uniteorganisation);
                                cr.setIdsousperiode(sousperiodecosting);
                                cr.setIdperiode(sousperiodecosting.getIdperiode());
                                cr.setCouverture(0d);
                                cr.setValeurrealisee(0d);
                                cr.setPas(0d);
                                cr.setValeurAnneeFin(0d);
                                cr.setValeurcible(0d);
                                cr.setValCibleFin(0d);
                                cr.setPasValCible(0d);

                                cr.setCUnitaireDebut(i.getIdindicateur().getCoutunitaire());
                                cr.setCoutUnitaire(i.getIdindicateur().getCoutunitaire());
                                cr.setCUnitaireFin(0d);
                                cr.setPasCoutUnitaire(0d);

                                cr.setBaq(0d);
                                cr.setTotal1(0d);
                                cr.setTotal2(0d);
                                cr.setBudget(0d);
                                cr.setBonusEquite(0d);
                                cr.setBonusQualite(0d);

                                selectedCrs.add(cr);
                            }
                        } else {
                            signalError("liste_indicateur_vide");
                        }
                    }

                    List<Couverturepopulation> cps = couverturepopulationFacadeLocal.findByPeriodeCostingUnite(periodecosting.getIdperiodecosting(), uniteorganisation.getIduniteorganisation());
                    if (cps.isEmpty()) {
                        for (Sousperiodecosting sp : spc) {
                            Couverturepopulation cp = new Couverturepopulation();
                            cp.setIdcouverturepopulation(couverturepopulationFacadeLocal.nextVal());
                            cp.setValeur(0d);
                            cp.setBaq(0d);
                            cp.setMajoration(0d);
                            cp.setPourcentage(0d);
                            cp.setIdperiode(sp.getIdperiode());
                            cp.setIdsousperiode(sp);
                            cp.setIduniteorganisation(uniteorganisation);

                            cp.setValDebutScoreE(0d);
                            cp.setValFinScoreE(0d);
                            cp.setValScoreEquite(0d);
                            cp.setPasScoreEquite(0d);
                            cp.setValScoreQualite(0d);
                            cp.setPasMajoration(0d);

                            cp.setBaq(0d);
                            cp.setMajoration(0d);
                            cp.setMajValDebut(0d);
                            cp.setMajValFin(0d);
                            couverturepopulationFacadeLocal.create(cp);
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
            if (mode.equals("Create")) {

                ut.begin();
                List<Sousperiodecosting> spcs = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);
                for (Ciblerealisation cr : selectedCrs) {
                    if (cr.getIdciblerealisation() == 0L) {
                        cr.setIdciblerealisation(ciblerealisationFacadeLocal.nextVal());
                        ciblerealisationFacadeLocal.create(cr);

                        for (Sousperiodecosting s : spcs) {
                            Budget b = new Budget();
                            b.setIdbudget(budgetFacadeLocal.nextVal());
                            b.setBaq(0d);
                            b.setBonusequite(0d);
                            b.setBonusqualite(0d);
                            b.setIdindicateur(cr.getIdindicateur());
                            b.setIduniteorganisation(uniteorganisation);
                            b.setIdperiode(cr.getIdperiode());
                            b.setCoutunitaire(0d);
                            b.setIdsousPeriode(s);
                            b.setTotal(0d);
                            b.setTotal1(0d);
                            b.setTotal2(0d);
                            budgetFacadeLocal.create(b);
                        }
                    } else {
                        ciblerealisationFacadeLocal.edit(cr);
                    }
                }

                ut.commit();

                Utilitaires.generate(ut, uniteorganisation, spcs, budgetFacadeLocal, ciblerealisationFacadeLocal, couverturepopulationFacadeLocal, null, financementFacadeLocal, financementbudgetFacadeLocal);
                selectedCrs.clear();

                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                signalSuccess();
            } else {
                RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').hide()");
                signalSuccess();
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
