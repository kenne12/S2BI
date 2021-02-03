package controllers.indicateur;

import entities.Indicateur;
import entities.Typeindicateur;
import java.io.Serializable;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.context.RequestContext;
import utils.SessionMBean;
import utils.Utilitaires;

@ManagedBean
@ViewScoped
public class IndicateurController extends AbstractIndicateurController implements Serializable {

    @PostConstruct
    private void init() {

    }

    public void prepareCreate() {
        if (!Utilitaires.isAccess(28L)) {
            signalError("acces_refuse");
            return;
        }
        this.mode = "Create";
        this.indicateur = new Indicateur();
        this.indicateur.setBaseline(0d);
        this.indicateur.setAnneeBaseline(0);
        this.indicateur.setCoutunitaire(0d);
        this.indicateur.setNumerateur("-");
        this.indicateur.setDenominateur("-");
        this.typeindicateur = new Typeindicateur();
        RequestContext.getCurrentInstance().execute("PF('PeriodeCreerDialog').show()");
    }

    public void prepareEdit() {
        try {
            if (indicateur != null) {
                if (!Utilitaires.isAccess(29L)) {
                    signalError("acces_refuse");
                    return;
                }
                this.mode = "Edit";
                typeindicateur = indicateur.getIdtypeindicateur();
                RequestContext.getCurrentInstance().execute("PF('PeriodeCreerDialog').show()");
            } else {
                signalError("not_row_selected");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void create() {
        try {
            if (this.mode.equals("Create")) {

                indicateur.setIdindicateur(indicateurFacadeLocal.nextVal());
                indicateur.setIdtypeindicateur(typeindicateur);
                indicateurFacadeLocal.create(indicateur);

                Utilitaires.saveOperation(this.mouchardFacadeLocal, "Enregistrement de l'indicateur : " + this.indicateur.getNom(), SessionMBean.getUserAccount());
                this.detail = this.modifier = this.supprimer = true;

                RequestContext.getCurrentInstance().execute("PF('PeriodeCreerDialog').hide()");
                signalSuccess();
            } else if (this.indicateur != null) {
                typeindicateur = typeindicateurFacadeLocal.find(typeindicateur.getIdtypeindicateur());
                indicateur.setIdtypeindicateur(typeindicateur);
                this.indicateurFacadeLocal.edit(indicateur);

                this.detail = this.modifier = this.supprimer = true;
                this.indicateur = null;
                RequestContext.getCurrentInstance().execute("PF('PeriodeCreerDialog').hide()");
                signalSuccess();
            } else {
                signalError("not_row_selected");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void delete() {
        try {
            if (this.indicateur != null) {

                if (!Utilitaires.isAccess(30L)) {
                    signalError("acces_refuse");
                    return;
                }

                ut.begin();
                indicateurFacadeLocal.remove(indicateur);
                ut.commit();

                Utilitaires.saveOperation(this.mouchardFacadeLocal, "Suppresion de l'indicateur : " + this.indicateur.getNom(), SessionMBean.getUserAccount());
                this.detail = this.modifier = this.supprimer = true;
                signalSuccess();
            } else {
                signalError("not_row_selected");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void signalError(String chaine) {
        this.routine.feedBack("information", "/resources/tool_images/error.png", this.routine.localizeMessage(chaine));
        RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
    }

    public void signalSuccess() {
        this.routine.feedBack("information", "/resources/tool_images/success.png", this.routine.localizeMessage("operation_reussie"));
        RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
    }

    public void signalException(Exception e) {
        this.routine.catchException(e, this.routine.localizeMessage("erreur_execution"));
        RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
    }
}
