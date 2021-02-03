package controllers.periode;

import entities.Periode;
import entities.TypePeriode;
import java.io.Serializable;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.context.RequestContext;
import utils.SessionMBean;
import utils.Utilitaires;

@ManagedBean
@ViewScoped
public class PeriodeController extends AbstractPeriodeController implements Serializable {

    @PostConstruct
    private void init() {
        this.periode = new Periode();
        this.periodeParent = new Periode();
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(16L)) {
                signalError("acces_refuse");
                return;
            }

            this.mode = "Create";
            this.periode = new Periode();
            this.periode.setEtat(true);
            this.periode.setPeriodeDebut(false);
            this.periode.setPeriodeFin(false);
            this.periodeParent = new Periode();
            this.typePeriode = new TypePeriode();

        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {

        try {
            if (periode != null) {

                if (!Utilitaires.isAccess(17L)) {
                    signalError("acces_refuse");
                    return;
                }

                if (this.periode.getIdparent() != 0) {
                    this.periodeParent = this.periodeFacadeLocal.find(this.periode.getIdparent());
                }

                typePeriode = periode.getIdtypePeriode();
                this.mode = "Edit";
                RequestContext.getCurrentInstance().execute("PF('PeriodeCreerDialog').show()");
            } else {
                signalError("not_row_selected");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public Periode findByIdparent(Integer id) {
        Periode p = new Periode();
        try {
            if (id != 0) {
                p = this.periodeFacadeLocal.find(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    public void create() {
        try {
            if (this.mode.equals("Create")) {

                if (typePeriode.getIdtypePeriode() == 0) {
                    signalError("periodicite_obligatoire");
                    return;
                }

                this.periode.setIdtypePeriode(typePeriode);

                if (this.periodeParent.getIdperiode() != 0) {
                    this.periode.setIdparent(this.periodeParent.getIdperiode());
                }

                this.periode.setIdperiode(this.periodeFacadeLocal.nextVal());
                this.periodeFacadeLocal.create(this.periode);

                Utilitaires.saveOperation(this.mouchardFacadeLocal, "Enregistrement de la période : " + this.periode.getNom(), SessionMBean.getUserAccount());
                this.periode = new Periode();
                this.detail = this.modifier = this.supprimer = true;

                RequestContext.getCurrentInstance().execute("PF('PeriodeCreerDialog').hide()");
                signalSuccess();
            } else if (this.periode != null) {

                if (typePeriode.getIdtypePeriode() == 0) {
                    signalError("periodicite_obligatoire");
                    return;
                }

                if (this.periodeParent.getIdperiode() != 0) {
                    this.periode.setIdparent(this.periodeParent.getIdperiode());
                } else {
                    this.periode.setIdparent(0);
                }
                this.periodeFacadeLocal.edit(this.periode);
                this.detail = this.modifier = this.supprimer = true;
                this.periode = new Periode();
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
            if (this.periode != null) {

                if (!Utilitaires.isAccess(19L)) {
                    signalError("acces_refuse");
                    return;
                }

                this.periodeFacadeLocal.remove(this.periode);

                Utilitaires.saveOperation(this.mouchardFacadeLocal, "Suppresion de la periode : " + this.periode.getNom(), SessionMBean.getUserAccount());
                this.periode = new Periode();
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
