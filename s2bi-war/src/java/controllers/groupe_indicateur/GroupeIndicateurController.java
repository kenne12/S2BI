/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.groupe_indicateur;

import entities.Groupindicateur;
import entities.Utilisateur;
import java.io.Serializable;
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
public class GroupeIndicateurController extends AbstractGroupeIndicateurController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public GroupeIndicateurController() {
    }

    @PostConstruct
    private void init() {
        
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(10L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            groupindicateur = new Groupindicateur();
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

            mode = "Edit";
            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void create() {
        try {
            if (mode.equals("Create")) {

                groupindicateur.setIdgroupindicateur(groupindicateurFacadeLocal.nextVal());
                groupindicateurFacadeLocal.create(groupindicateur);

                Utilitaires.saveOperation(mouchardFacadeLocal, "Enregistrement du groupe d'indicateur  : " + groupindicateur.getNom(), SessionMBean.getUserAccount());
                groupindicateur = new Groupindicateur();
                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                signalSuccess();
            } else {
                if (groupindicateur != null) {
                    groupindicateurFacadeLocal.edit(groupindicateur);
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
            if (groupindicateur != null) {

                if (!Utilitaires.isAccess(12L)) {
                    signalError("acces_refuse");
                    return;
                }
                groupindicateurFacadeLocal.remove(groupindicateur);
                Utilitaires.saveOperation(mouchardFacadeLocal, "Suppresion du groupe d'indicateur : " + groupindicateur.getNom(), SessionMBean.getUserAccount());
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
