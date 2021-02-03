/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.population;

import entities.Couverturepopulation;
import entities.Periodecosting;
import entities.Sousperiodecosting;
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
public class PopulationController extends AbstractPopulationController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public PopulationController() {
    }

    @PostConstruct
    private void init() {
        couverturepopulation = new Couverturepopulation();
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(32L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            enabledSelect = false;
            selecteds.clear();

            uniteorganisation = new Uniteorganisation();
            periodecosting = SessionMBean.getPeriodeCosting();
            periodecosting.setIdperiodecosting(0);
            uniteorganisation.setIduniteorganisation(0);

            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (couverturepopulation != null) {
                if (!Utilitaires.isAccess(32L)) {
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
            selecteds.clear();
            if (periodecosting.getIdperiodecosting() != 0) {
                if (uniteorganisation.getIduniteorganisation() != 0) {

                    List<Couverturepopulation> cps = couverturepopulationFacadeLocal.findByPeriodeCostingUnite(periodecosting.getIdperiodecosting(), uniteorganisation.getIduniteorganisation());
                    List<Sousperiodecosting> spc = sousperiodecostingFacadeLocal.findByPeriodeCosting(periodecosting.getIdperiodecosting());

                    if (!cps.isEmpty()) {
                        update_flag = false;
                        selecteds.addAll(cps);
                    } else {
                        update_flag = true;
                        for (Sousperiodecosting s : spc) {

                            Couverturepopulation c = new Couverturepopulation();
                            c.setIdcouverturepopulation(0l);
                            c.setIduniteorganisation(uniteorganisation);
                            c.setIdperiode(s.getIdperiode());
                            c.setIdsousperiode(s);
                            c.setValeur(0d);
                            c.setPourcentage(0d);

                            c.setValDebutScoreE(0d);
                            c.setValFinScoreE(0d);
                            c.setValScoreEquite(0d);
                            c.setPasScoreEquite(0d);
                            c.setPasMajoration(0d);

                            c.setBaq(0d);
                            c.setMajoration(0d);
                            c.setMajValDebut(0d);
                            c.setMajValFin(0d);
                            c.setValScoreQualite(0d);

                            selecteds.add(c);
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

                for (Couverturepopulation c : selecteds) {
                    if (c.getIdcouverturepopulation() != 0L) {
                        couverturepopulationFacadeLocal.edit(couverturepopulation);
                    } else {
                        c.setIdcouverturepopulation(couverturepopulationFacadeLocal.nextVal());
                        couverturepopulationFacadeLocal.create(c);
                        Utilitaires.saveOperation(mouchardFacadeLocal, "Saisie de la population de l'unité d'organisation  : " + uniteorganisation.getNom() + " A la periode : " + c.getIdperiode().getNom() + " Valeur : " + c.getValeur(), SessionMBean.getUserAccount());
                    }
                }
                ut.commit();
                periodecosting = new Periodecosting();
                couverturepopulation = null;
                selecteds.clear();

                List<Sousperiodecosting> spcs = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);
                Utilitaires.generate(ut, uniteorganisation, spcs, budgetFacadeLocal, ciblerealisationFacadeLocal, couverturepopulationFacadeLocal, null, financementFacadeLocal, financementbudgetFacadeLocal);

                if (update_flag) {
                    RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                    signalSuccess();
                    return;
                }

                RequestContext.getCurrentInstance().execute("PF('AjaxNotifyDialog').hide()");
                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                routine.feedBack("information", "/resources/tool_images/success.png", routine.localizeMessage("operation_reussie") + " : " + routine.localizeMessage("necessite_mise_a_jour_cible"));
                RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
            } else {
                if (couverturepopulation != null) {

                    ut.begin();
                    couverturepopulationFacadeLocal.edit(couverturepopulation);
                    couverturepopulation = null;
                    ut.commit();

                    RequestContext.getCurrentInstance().execute("PF('AjaxNotifyDialog').hide()");
                    RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').hide()");
                    routine.feedBack("information", "/resources/tool_images/success.png", routine.localizeMessage("operation_reussie") + " : " + routine.localizeMessage("necessite_mise_a_jour_cible"));
                    RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
                } else {
                    signalError("not_row_selected");
                }
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
