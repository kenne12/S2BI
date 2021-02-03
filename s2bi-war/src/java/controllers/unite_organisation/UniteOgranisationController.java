package controllers.unite_organisation;

import entities.Niveaupyramide;
import entities.Typeuniteorganisation;
import entities.Uniteorganisation;
import java.io.Serializable;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.context.RequestContext;
import utils.SessionMBean;
import utils.Utilitaires;

@ManagedBean
@ViewScoped
public class UniteOgranisationController extends AbstractUniteOrganisationController implements Serializable {

    @PostConstruct
    private void init() {

    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(21L)) {
                signalError("acces_refuse");
                return;
            }

            this.mode = "Create";

            uniteorganisation = new Uniteorganisation();
            uniteorganisation.setCostingfosa(true);
            uniteorganisationParent = new Uniteorganisation();

            typeuniteorganisation = new Typeuniteorganisation();
            niveaupyramide = new Niveaupyramide();
            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (uniteorganisation != null) {

                if (!Utilitaires.isAccess(22L)) {
                    signalError("acces_refuse");
                    return;
                }

                if (this.uniteorganisation.getIdparent() != 0) {
                    this.uniteorganisationParent = this.uniteorganisationFacadeLocal.find(this.uniteorganisation.getIdparent());
                }

                typeuniteorganisation = uniteorganisation.getIdtypeuniteorganisation();
                niveaupyramide = uniteorganisation.getIdniveaupyramide();
                this.mode = "Edit";
            } else {
                signalError("not_row_selected");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public Uniteorganisation findByIdparent(Integer id) {
        Uniteorganisation u = new Uniteorganisation();
        try {
            if (id != 0) {
                u = this.uniteorganisationFacadeLocal.find(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public void create() {
        try {
            if (this.mode.equals("Create")) {
                this.uniteorganisation.setIduniteorganisation(this.uniteorganisationFacadeLocal.nextVal());

                if (this.uniteorganisationParent.getIduniteorganisation() != 0) {
                    this.uniteorganisation.setIdparent(this.uniteorganisationParent.getIduniteorganisation());
                } else {
                    uniteorganisation.setIdparent(0);
                }
                uniteorganisation.setIdniveaupyramide(niveaupyramide);
                uniteorganisation.setIdtypeuniteorganisation(typeuniteorganisation);

                this.uniteorganisationFacadeLocal.create(this.uniteorganisation);

                Utilitaires.saveOperation(this.mouchardFacadeLocal, "Enregistrement de l'unité d'organisation : " + this.uniteorganisation.getNom(), SessionMBean.getUserAccount());
                this.uniteorganisation = new Uniteorganisation();
                uniteorganisationParent = new Uniteorganisation();
                this.niveaupyramide = new Niveaupyramide();
                this.typeuniteorganisation = new Typeuniteorganisation();
                this.detail = this.modifier = this.supprimer = true;

                RequestContext.getCurrentInstance().execute("PF('PeriodeCreerDialog').hide()");
                signalSuccess();
            } else if (this.typeuniteorganisation != null) {
                if (this.uniteorganisationParent.getIduniteorganisation() != 0) {
                    this.uniteorganisation.setIdparent(this.uniteorganisationParent.getIduniteorganisation());
                } else {
                    uniteorganisation.setIdparent(0);
                }
                uniteorganisation.setIdniveaupyramide(niveaupyramide);
                typeuniteorganisation = typeuniteorganisationFacadeLocal.find(typeuniteorganisation.getIdtypeuniteorganisation());
                uniteorganisation.setIdtypeuniteorganisation(typeuniteorganisation);

                this.uniteorganisationFacadeLocal.edit(this.uniteorganisation);
                this.detail = this.modifier = this.supprimer = true;
                this.uniteorganisation = new Uniteorganisation();
                uniteorganisationParent = new Uniteorganisation();
                this.niveaupyramide = new Niveaupyramide();
                this.typeuniteorganisation = new Typeuniteorganisation();
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
            if (this.uniteorganisation != null) {

                if (!Utilitaires.isAccess(23L)) {
                    signalError("acces_refuse");
                    return;
                }

                if (!this.uniteorganisationFacadeLocal.findByOrganisationUnitParent(uniteorganisation.getIduniteorganisation()).isEmpty()) {
                    signalError("unite_organisation_parent_suppression");
                    return;
                }

                this.uniteorganisationFacadeLocal.remove(this.uniteorganisation);

                Utilitaires.saveOperation(this.mouchardFacadeLocal, "Suppresion de l'unité d'organisation : " + this.uniteorganisation.getNom(), SessionMBean.getUserAccount());
                this.uniteorganisation = new Uniteorganisation();
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
