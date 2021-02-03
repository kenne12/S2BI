/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.projection_majoration;

import entities.Couverturepopulation;
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
public class MajorationController extends AbstractMajorationController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public MajorationController() {
    }

    @PostConstruct
    private void init() {
        couverturepopulation = new Couverturepopulation();
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(39L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            enabledSelect = false;
            selecteds.clear();

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
                if (!Utilitaires.isAccess(39L)) {
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
                        couverturepopulation = cps.get(0);
                        selecteds.addAll(cps);
                    } else {

                        couverturepopulation = new Couverturepopulation();
                        couverturepopulation.setIdcouverturepopulation(0L);
                        couverturepopulation.setValDebutScoreE(0d);
                        couverturepopulation.setValFinScoreE(0d);

                        for (Sousperiodecosting s : spc) {
                            Couverturepopulation c = new Couverturepopulation();
                            c.setIdcouverturepopulation(0L);
                            c.setIduniteorganisation(uniteorganisation);
                            c.setIdperiode(s.getIdperiode());
                            c.setIdsousperiode(s);
                            c.setValDebutScoreE(0d);
                            c.setValFinScoreE(0d);
                            c.setValScoreEquite(0d);
                            c.setPasScoreEquite(0d);
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

    public void updateRenderedColumn() {

    }

    public void edit() {
        try {
            if (mode.equals("Edit")) {
                if (couverturepopulation != null) {

                    ut.begin();
                    couverturepopulationFacadeLocal.edit(couverturepopulation);
                    ut.commit();

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

    public void generate() {
        try {

            if (modeProjection == 0) {
                signalError("choisir_mode_generation");
                return;
            }

            ut.begin();
            int i = 1;
            for (Couverturepopulation cp : selecteds) {

                if (modeProjection == 1) {

                    Double pas = ((couverturepopulation.getMajValFin() - couverturepopulation.getMajValDebut()) / (selecteds.size() - 1));
                    if (i == 1) {
                        cp.setMajoration(couverturepopulation.getMajValDebut());
                    } else {
                        cp.setMajoration(couverturepopulation.getMajValDebut() + ((i - 1) * pas));
                    }

                    if (pas < 0) {
                        cp.setPasMajoration(0d);
                    } else {
                        cp.setPasMajoration(pas);
                    }

                    cp.setMajValDebut(couverturepopulation.getMajValDebut());
                    cp.setMajValFin(couverturepopulation.getMajValFin());

                    if (cp.getIdcouverturepopulation() != 0L) {
                        couverturepopulationFacadeLocal.edit(cp);
                    } else {
                        cp.setIdcouverturepopulation(couverturepopulationFacadeLocal.nextVal());
                        couverturepopulationFacadeLocal.create(cp);
                    }
                }

                i++;
            }
            ut.commit();

            List<Sousperiodecosting> spcs = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);
            Utilitaires.generate(ut, uniteorganisation, spcs, budgetFacadeLocal, ciblerealisationFacadeLocal, couverturepopulationFacadeLocal, null, financementFacadeLocal, financementbudgetFacadeLocal);

            signalSuccess();
        } catch (Exception e) {
            e.printStackTrace();
            signalException(e);
        }
    }

    public void delete() {
        try {
            if (couverturepopulation != null) {

                if (!Utilitaires.isAccess(12L)) {
                    signalError("acces_refuse");
                    return;
                }

                ut.begin();
                couverturepopulationFacadeLocal.remove(couverturepopulation);
                ut.commit();
                Utilitaires.saveOperation(mouchardFacadeLocal, "Suppresion de la periode de costing : " + periodecosting.getLibelle(), SessionMBean.getUserAccount());
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
