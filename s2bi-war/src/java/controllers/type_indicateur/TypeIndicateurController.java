/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.type_indicateur;

import entities.Groupindicateur;
import entities.Typeindicateur;
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
public class TypeIndicateurController extends AbstractTypeIndicateurController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public TypeIndicateurController() {
    }

    @PostConstruct
    private void init() {

    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(13L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            typeindicateur = new Typeindicateur();
            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (!Utilitaires.isAccess(14L)) {
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

                typeindicateur.setIdtypeindicateur(typeindicateurFacadeLocal.nextVal());
                typeindicateurFacadeLocal.create(typeindicateur);

                Utilitaires.saveOperation(mouchardFacadeLocal, "Enregistrement du type d'indicateur  : " + typeindicateur.getNom(), SessionMBean.getUserAccount());
                typeindicateur = new Typeindicateur();
                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                signalSuccess();
            } else {
                if (typeindicateur != null) {
                    typeindicateurFacadeLocal.edit(typeindicateur);
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
            if (typeindicateur != null) {

                if (!Utilitaires.isAccess(15L)) {
                    signalError("acces_refuse");
                    return;
                }
                typeindicateurFacadeLocal.remove(typeindicateur);
                Utilitaires.saveOperation(mouchardFacadeLocal, "Suppresion du type d'indicateur : " + typeindicateur.getNom(), SessionMBean.getUserAccount());
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
