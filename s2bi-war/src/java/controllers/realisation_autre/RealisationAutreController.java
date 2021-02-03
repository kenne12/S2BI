/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.realisation_autre;

import entities.Ciblerealisation;
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
public class RealisationAutreController extends AbstractRealisationAutreController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public RealisationAutreController() {
    }

    @PostConstruct
    private void init() {
        couverturepopulation = new Couverturepopulation();
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(10L)) {
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
            if (!Utilitaires.isAccess(11L)) {
                signalError("acces_refuse");
                return;
            }

            if (couverturepopulation == null) {
                signalError("not_selected_row");
                return;
            }
            mode = "Edit";
            enabledSelect = true;

            RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').show()");
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
                        signalError("cible_non_programmee");
                        return;
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
            selectedCrs.get(index).setCouverture(valeur);
        } catch (Exception e) {
            selectedCrs.get(index).setCouverture(0d);
        }
    }

    public void create() {
        try {
            if (mode.equals("Create")) {

                ut.begin();

                for (Ciblerealisation cr : selectedCrs) {
                    if (cr.getIdciblerealisation() == 0L) {
                        cr.setIdciblerealisation(ciblerealisationFacadeLocal.nextVal());
                        ciblerealisationFacadeLocal.create(cr);
                    } else {
                        ciblerealisationFacadeLocal.edit(cr);
                    }
                }

                ut.commit();
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

    public void delete() {
        try {
            if (ciblerealisation != null) {

                if (!Utilitaires.isAccess(12L)) {
                    signalError("acces_refuse");
                    return;
                }

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
