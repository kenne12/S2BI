/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.periode_costing;

import entities.Periode;
import entities.Periodecosting;
import entities.Sousperiodecosting;
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
public class PeriodeCostingController extends AbstractPeriodeCostingController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public PeriodeCostingController() {
    }

    @PostConstruct
    private void init() {

    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(26L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            periodecosting = new Periodecosting();
            periodecosting.setLibelle("-");
            sousperiodecostings.clear();
            selectedPeriods.clear();

            enabledSelect = false;
            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (periodecosting != null) {
                if (!Utilitaires.isAccess(26L)) {
                    signalError("acces_refuse");
                    return;
                }

                mode = "Edit";
                enabledSelect = true;
                sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCosting(periodecosting.getIdperiodecosting());
                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
            } else {
                signalError("not_selected_row");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareSelectPeriode() {
        selectedPeriods.clear();
    }

    public void selectPeriod() {
        try {

            if (selectedPeriods.isEmpty()) {
                signalError("tableau_vide");
                return;
            }

            sousperiodecostings.clear();

            int conteur = 0;
            for (Periode p : selectedPeriods) {
                Sousperiodecosting spc = new Sousperiodecosting();
                spc.setIdsousperiode(0);
                spc.setIdperiode(p);
                spc.setPeriodedebut(false);
                spc.setPeriodefin(false);
                if (conteur == 0) {
                    spc.setPeriodedebut(true);
                }
                if ((conteur + 1) == selectedPeriods.size()) {
                    spc.setPeriodefin(true);
                }

                spc.setNumero((conteur + 1));
                conteur += 1;

                sousperiodecostings.add(spc);

                RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').hide()");
                signalSuccess();
            }

        } catch (Exception e) {
            signalException(e);
        }
    }

    public void create() {
        try {
            if (mode.equals("Create")) {

                ut.begin();
                periodecosting.setIdperiodecosting(periodecostingFacadeLocal.nextVal());
                periodecostingFacadeLocal.create(periodecosting);

                for (Sousperiodecosting spc : sousperiodecostings) {

                    spc.setIdsousperiode(sousperiodecostingFacadeLocal.nextVal());
                    spc.setIdperiodecosting(periodecosting);
                    sousperiodecostingFacadeLocal.create(spc);

                    if (spc.getPeriodedebut()) {
                        spc.getIdperiode().setPeriodeDebut(true);
                        periodeFacadeLocal.edit(spc.getIdperiode());
                    }

                    if (spc.getPeriodefin()) {
                        spc.getIdperiode().setPeriodeFin(true);
                        periodeFacadeLocal.edit(spc.getIdperiode());
                    }
                }
                ut.commit();

                Utilitaires.saveOperation(mouchardFacadeLocal, "Enregistrement de la periode de costing  : " + periodecosting.getLibelle(), SessionMBean.getUserAccount());
                sousperiodecostings.clear();
                selectedPeriods.clear();
                periodecosting = new Periodecosting();
                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                signalSuccess();
            } else {
                if (periodecosting != null) {

                    ut.begin();
                    periodecostingFacadeLocal.edit(periodecosting);

                    for (Sousperiodecosting spc : sousperiodecostings) {
                        sousperiodecostingFacadeLocal.edit(spc);

                        if (spc.getPeriodedebut()) {
                            spc.getIdperiode().setPeriodeDebut(true);
                            periodeFacadeLocal.edit(spc.getIdperiode());
                        }

                        if (spc.getPeriodefin()) {
                            spc.getIdperiode().setPeriodeFin(true);
                            periodeFacadeLocal.edit(spc.getIdperiode());
                        }

                    }
                    ut.commit();

                    RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
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
            if (periodecosting != null) {

                if (!Utilitaires.isAccess(26L)) {
                    signalError("acces_refuse");
                    return;
                }

                ut.begin();

                List<Sousperiodecosting> list = sousperiodecostingFacadeLocal.findByPeriodeCosting(periodecosting.getIdperiodecosting());
                for (Sousperiodecosting s : list) {
                    sousperiodecostingFacadeLocal.remove(s);
                }

                periodecostingFacadeLocal.remove(periodecosting);
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
