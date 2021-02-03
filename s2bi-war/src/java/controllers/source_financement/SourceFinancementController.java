/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.source_financement;

import entities.Sourcefinancement;
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
public class SourceFinancementController extends AbstractSourceFinancementController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public SourceFinancementController() {
    }
    
    @PostConstruct
    private void init() {
        
    }
    
    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(24L)) {
                signalError("acces_refuse");
                return;
            }
            
            mode = "Create";
            sourcefinancement = new Sourcefinancement();
            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }
    
    public void prepareEdit() {
        try {
            if (sourcefinancement != null) {                
                if (!Utilitaires.isAccess(24L)) {
                    signalError("acces_refuse");
                    return;
                }
                
                mode = "Edit";
                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
            } else {
                signalError("not_row_selected");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }
    
    public void create() {
        try {
            if (mode.equals("Create")) {
                
                sourcefinancement.setIdsourcefinancement(sourcefinancementFacadeLocal.nextVal());
                sourcefinancementFacadeLocal.create(sourcefinancement);
                
                Utilitaires.saveOperation(mouchardFacadeLocal, "Enregistrement de la source de financement  : " + sourcefinancement.getNom(), SessionMBean.getUserAccount());
                sourcefinancement = new Sourcefinancement();
                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                signalSuccess();
            } else {
                if (sourcefinancement != null) {
                    sourcefinancementFacadeLocal.edit(sourcefinancement);
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
            if (sourcefinancement != null) {
                
                if (!Utilitaires.isAccess(24L)) {
                    signalError("acces_refuse");
                    return;
                }
                sourcefinancementFacadeLocal.remove(sourcefinancement);
                Utilitaires.saveOperation(mouchardFacadeLocal, "Suppresion de la source de financement : " + sourcefinancement.getNom(), SessionMBean.getUserAccount());
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
