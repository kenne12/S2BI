/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.utilisateur_costing;

import entities.Periodecosting;
import entities.Utilisateur;
import entities.UtilisateurCosting;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.context.RequestContext;
import utils.JsfUtil;
import utils.SessionMBean;
import utils.Utilitaires;

/**
 *
 * @author Gervais
 */
@ManagedBean
@ViewScoped
public class UtilisateurCostingController extends AbstractUtilisateurCostingController implements UtilisateurCostingInterfaceController, Serializable {

    @PostConstruct
    private void initAcces() {

    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(10L)) {
                signalError("acces_refuse");
                return;
            }
            dualCosting.getSource().clear();
            dualCosting.getTarget().clear();
            utilisateur = new Utilisateur();
            RequestContext.getCurrentInstance().execute("PF('AccesCreerDialog').show()");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void viewAccess(Utilisateur u) {
        try {
            this.utilisateur = u;
            utilisateurCostings = utilisateurCostingFacadeLocal.findByUtilisateur(u.getIdutilisateur());
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Echec");
        }
    }

    public void handleTypeChange() {
        dualCosting.getSource().clear();
        dualCosting.getTarget().clear();
        try {
            if (utilisateur.getIdutilisateur() != null) {

                List<UtilisateurCosting> userCTemps = utilisateurCostingFacadeLocal.findByUtilisateur(utilisateur.getIdutilisateur());
                if (userCTemps.isEmpty()) {
                    dualCosting.setSource(periodecostingFacadeLocal.findAllNom());
                } else {
                    List<Periodecosting> pcTarget = new ArrayList<>();

                    for (UtilisateurCosting uc : userCTemps) {
                        pcTarget.add(uc.getIdperiodeCosting());
                    }

                    dualCosting.getTarget().addAll(pcTarget);
                    dualCosting.getSource().addAll(periodecostingFacadeLocal.findAllNom());
                    dualCosting.getSource().removeAll(pcTarget);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void save() {
        try {
            if (utilisateur.getIdutilisateur() != null) {
                utilisateur = utilisateurFacadeLocal.find(utilisateur.getIdutilisateur());

                for (Periodecosting p : dualCosting.getSource()) {
                    UtilisateurCosting u = utilisateurCostingFacadeLocal.findByUserCosting(utilisateur.getIdutilisateur(), p.getIdperiodecosting());

                    if (u != null) {
                        utilisateurCostingFacadeLocal.remove(u);
                        Utilitaires.saveOperation(mouchardFacadeLocal, "RETRAIT DU COSTING -> " + p.getLibelle() + " à l'utilisateur -> " + utilisateur.getNom() + " " + utilisateur.getPrenom(), SessionMBean.getUserAccount());
                    }
                }

                for (Periodecosting p : dualCosting.getTarget()) {
                    UtilisateurCosting u = utilisateurCostingFacadeLocal.findByUserCosting(utilisateur.getIdutilisateur(), p.getIdperiodecosting());
                    if (u == null) {
                        u = new UtilisateurCosting();
                        u.setIdUtilisateurCosting(utilisateurCostingFacadeLocal.nextVal());
                        u.setIdperiodeCosting(p);
                        u.setIdutilisateur(utilisateur);
                        utilisateurCostingFacadeLocal.create(u);
                        Utilitaires.saveOperation(mouchardFacadeLocal, "ATTRIBUTION DU COSTING -> " + p.getLibelle() + " à l'utilisateur -> " + utilisateur.getNom() + " " + utilisateur.getPrenom(), SessionMBean.getUserAccount());
                    }
                }

                signalSuccess();
                RequestContext.getCurrentInstance().execute("PF('AccesCreerDialog').hide()");

            } else {
                signalError("control_formulaire");
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
