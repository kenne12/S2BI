/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.financement;

import entities.Bailleurfond;
import entities.Financement;
import entities.Sousperiodecosting;
import entities.Uniteorganisation;
import java.io.Serializable;
import java.util.ArrayList;
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
public class FinancementController extends AbstractFinancementController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public FinancementController() {
    }

    @PostConstruct
    private void init() {

    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(42L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            enabledSelect = false;
            selectedFinancements.clear();

            uniteorganisation = new Uniteorganisation();
            periodecosting = SessionMBean.getPeriodeCosting();
            sousperiodecosting = new Sousperiodecosting();
            uniteorganisation.setIduniteorganisation(0);

            sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCosting(periodecosting.getIdperiodecosting());

            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (financement != null) {

                if (!Utilitaires.isAccess(42L)) {
                    signalError("acces_refuse");
                    return;
                }

                mode = "Edit";
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
            selectedFinancements.clear();
            if (periodecosting.getIdperiodecosting() != 0) {
                if (sousperiodecosting.getIdsousperiode() != 0) {

                    if (typeuniteorganisation.getIdtypeuniteorganisation() != 0) {

                        sousperiodecosting = sousperiodecostingFacadeLocal.find(sousperiodecosting.getIdsousperiode());

                        List<Financement> financementTemps = financementFacadeLocal.findBySousPeriodeTypeUo(sousperiodecosting.getIdsousperiode(), typeuniteorganisation.getIdtypeuniteorganisation());
                        if (!financementTemps.isEmpty()) {
                            selectedFinancements.addAll(financementTemps);
                            List<Bailleurfond> bailleurTmps = new ArrayList<>();
                            for (Financement f : financementTemps) {
                                bailleurTmps.add(f.getIdbailleurfond());
                            }

                            List<Bailleurfond> bailleurTmps1 = bailleurfondFacadeLocal.findAllNom();
                            bailleurTmps1.removeAll(bailleurTmps);
                            for (Bailleurfond b : bailleurTmps1) {
                                Financement f = new Financement();
                                f.setIdfinancement(0L);
                                f.setIdbailleurfond(b);
                                f.setIdtypeuniteorganisation(typeuniteorganisation);
                                f.setIdperiode(sousperiodecosting.getIdperiode());
                                f.setIdsousPeriode(sousperiodecosting);

                                selectedFinancements.add(f);
                            }
                            return;
                        }

                        List<Bailleurfond> bailleurTmps1 = bailleurfondFacadeLocal.findAllNom();
                        for (Bailleurfond b : bailleurTmps1) {
                            Financement f = new Financement();
                            f.setIdfinancement(0L);
                            f.setIdbailleurfond(b);
                            f.setIdtypeuniteorganisation(typeuniteorganisation);
                            f.setIdperiode(sousperiodecosting.getIdperiode());
                            f.setIdsousPeriode(sousperiodecosting);

                            selectedFinancements.add(f);
                        }
                        return;
                    }
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

                for (Financement f : selectedFinancements) {
                    if (f.getIdfinancement() != 0L) {
                        financementFacadeLocal.edit(f);
                    } else {
                        try {
                            if (f.getPourcentage() != null && f.getPourcentage() != 0) {
                                f.setIdfinancement(financementFacadeLocal.nextVal());
                                financementFacadeLocal.create(f);
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }

                List<Sousperiodecosting> spcs = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);
                Utilitaires.generate(ut, uniteorganisation, spcs, budgetFacadeLocal, ciblerealisationFacadeLocal, couverturepopulationFacadeLocal, null, financementFacadeLocal, financementbudgetFacadeLocal);

                ut.commit();

                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                signalSuccess();
            } else {
                if (financement != null) {

                    ut.begin();
                    financementFacadeLocal.edit(financement);
                    ut.commit();

                    List<Sousperiodecosting> spcs = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);
                    Utilitaires.generate(ut, uniteorganisation, spcs, budgetFacadeLocal, ciblerealisationFacadeLocal, couverturepopulationFacadeLocal, null, financementFacadeLocal, financementbudgetFacadeLocal);

                    RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').hide()");
                    signalSuccess();
                } else {
                    signalError("not_row_selected");
                }
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void delete() {
        try {
            if (financement != null) {

                if (!Utilitaires.isAccess(12L)) {
                    signalError("acces_refuse");
                    return;
                }

                ut.begin();
                financementFacadeLocal.remove(financement);
                ut.commit();
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
