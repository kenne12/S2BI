/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.projection_devise;

import entities.Devise;
import entities.DevisePeriode;
import entities.Periode;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.context.RequestContext;
import utils.Utilitaires;

/**
 *
 * @author kenne
 */
@ManagedBean
@ViewScoped
public class ProjectionDeviseController extends AbstractProjectionDeviseController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public ProjectionDeviseController() {
    }

    @PostConstruct
    private void init() {

    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(45L)) {
                signalError("acces_refuse");
                return;
            }
            mode = "Create";
            enabledSelect = false;
            selectedsDp.clear();

            devise = new Devise();

            devise.setIddevise(0);
            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (devisePeriode != null) {
                if (!Utilitaires.isAccess(45L)) {
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
            selectedsDp.clear();
            if (devise.getIddevise() != 0 && devise.getIddevise() != null) {

                List<DevisePeriode> dps = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise());
                if (!dps.isEmpty()) {
                    selectedsDp.addAll(dps);
                    List<Periode> periods = new ArrayList<>();
                    for (DevisePeriode dp : dps) {
                        periods.add(dp.getIdperiode());
                    }

                    List<Periode> periodAll = periodeFacadeLocal.findAllRange();
                    periodAll.removeAll(periods);

                    for (Periode p : periodAll) {
                        DevisePeriode dp = new DevisePeriode();
                        dp.setIddevisePeriode(0);
                        dp.setIddevise(devise);
                        dp.setIdperiode(p);
                        dp.setValeur(null);
                        selectedsDp.add(dp);
                    }
                    return;
                } else {
                    selectedsDp.clear();
                    for (Periode p : periodeFacadeLocal.findAllRange()) {
                        DevisePeriode dp = new DevisePeriode();
                        dp.setIddevisePeriode(0);
                        dp.setIddevise(devise);
                        dp.setIdperiode(p);
                        dp.setValeur(null);
                        selectedsDp.add(dp);
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

                for (DevisePeriode dp : selectedsDp) {
                    if (dp.getIddevisePeriode() != 0L) {
                        devisePeriodeFacadeLocal.edit(dp);
                    } else {
                        if (dp.getValeur() != null) {
                            dp.setIddevisePeriode(devisePeriodeFacadeLocal.nextVal());
                            devisePeriodeFacadeLocal.create(dp);
                        }
                    }
                }
                ut.commit();
                devise = new Devise();
                devisePeriode = null;
                selectedsDp.clear();

                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                signalSuccess();
            } else {
                if (devisePeriode != null) {

                    ut.begin();
                    devisePeriodeFacadeLocal.edit(devisePeriode);
                    devisePeriode = null;
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

    public void delete() {
        try {
            if (devisePeriode != null) {

                if (!Utilitaires.isAccess(45L)) {
                    signalError("acces_refuse");
                    return;
                }

                ut.begin();
                devisePeriodeFacadeLocal.remove(devisePeriode);
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
