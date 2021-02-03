/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.utilisateurs;

import entities.Utilisateur;
import java.io.Serializable;
import java.util.Date;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.context.RequestContext;
import utils.JsfUtil;
import utils.SessionMBean;
import utils.ShaHash;
import utils.Utilitaires;

/**
 *
 * @author kenne
 */
@ManagedBean
@ViewScoped
public class UtilisateurController extends AbstractUtilisateurController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public UtilisateurController() {
    }

    @PostConstruct
    private void init() {
        utilisateur = new Utilisateur();
        templates.clear();
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(2L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";

            utilisateur = new Utilisateur();
            utilisateur.setEtat(true);
            utilisateur.setPhoto("user_avatar.png");

            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (!Utilitaires.isAccess(3L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Edit";
            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void create() {
        try {
            if (mode.equals("Create")) {

                if (utilisateurFacadeLocal.findByLogin(utilisateur.getLogin()) == null) {
                    signalError("existance_login_message");
                    return;
                }

                utilisateur.setIdutilisateur(utilisateurFacadeLocal.nextVal());
                utilisateur.setPassword(new ShaHash().hash(utilisateur.getPassword()));
                utilisateur.setEtat(true);
                utilisateur.setDatecreation(new Date());
                utilisateurFacadeLocal.create(utilisateur);
                Utilitaires.saveOperation(mouchardFacadeLocal, "Enregistrement de l'utilisateur : " + utilisateur.getNom() + " " + utilisateur.getPrenom(), SessionMBean.getUserAccount());
                utilisateur = new Utilisateur();
                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                signalSuccess();

            } else {
                if (utilisateur != null) {
                    utilisateurFacadeLocal.edit(utilisateur);
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

    public void reinitialiseAccount(Utilisateur utilisateur) {
        try {
            if (!Utilitaires.isAccess(5L)) {
                signalError("acces_refuse");
                return;
            }
            utilisateur.setPassword(new ShaHash().hash("123456"));
            utilisateurFacadeLocal.edit(utilisateur);
            Utilitaires.saveOperation(mouchardFacadeLocal, "Réinitilisation du compte utilisateur de -> " + utilisateur.getNom() + " " + utilisateur.getPrenom(), SessionMBean.getUserAccount());
            signalSuccess();
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void delete() {
        try {
            if (utilisateur != null) {

                if (!Utilitaires.isAccess(4L)) {
                    signalError("acces_refuse");
                    return;
                }
                utilisateurFacadeLocal.remove(utilisateur);
                Utilitaires.saveOperation(mouchardFacadeLocal, "Suppresion de l'utilisateur : " + utilisateur.getNom() + " " + utilisateur.getPrenom(), SessionMBean.getUserAccount());

                signalSuccess();
            } else {
                signalError("not_row_selected");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void changeStatus(Utilisateur utilisateur, String mode) {
        try {
            if (mode.equals("activer")) {

                if (!Utilitaires.isAccess(6L)) {
                    signalError("acces_refuse");
                    return;
                }
                utilisateur.setEtat(true);
                utilisateurFacadeLocal.edit(utilisateur);
                Utilitaires.saveOperation(mouchardFacadeLocal, "Activation du compte de l'utilisateur : " + utilisateur.getNom() + " " + utilisateur.getPrenom(), SessionMBean.getUserAccount());
                JsfUtil.addSuccessMessage("Operation réussie");
            } else {

                if (!Utilitaires.isAccess(7L)) {
                    signalError("acces_refuse");
                    return;
                }
                utilisateur.setEtat(false);
                utilisateurFacadeLocal.edit(utilisateur);
                Utilitaires.saveOperation(mouchardFacadeLocal, "Désativation du compte de l'utilisateur : " + utilisateur.getNom() + " " + utilisateur.getPrenom(), SessionMBean.getUserAccount());
                JsfUtil.addSuccessMessage("Operation réussie");
            }
        } catch (Exception e) {
            e.printStackTrace();
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
