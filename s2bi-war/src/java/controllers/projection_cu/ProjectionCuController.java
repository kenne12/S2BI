/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.projection_cu;

import entities.Ciblerealisation;
import entities.Couverturepopulation;
import entities.Sousperiodecosting;
import entities.Uniteorganisation;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import org.primefaces.context.RequestContext;
import utils.SessionMBean;
import utils.Utilitaires;

/**
 *
 * @author kenne
 */
@ManagedBean
@SessionScoped
public class ProjectionCuController extends AbstractProjectionCuController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public ProjectionCuController() {
    }

    @PostConstruct
    private void init() {
        couverturepopulation = new Couverturepopulation();
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(38L)) {
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

            renderedCible = true;
            renderedPas = false;

            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (!Utilitaires.isAccess(38L)) {
                signalError("acces_refuse");
                return;
            }

            if (ciblerealisation == null) {
                signalError("not_selected_row");
                return;
            }

            ciblerealisations.clear();
            List<Ciblerealisation> crTemps = ciblerealisationFacadeLocal.findByUnitePeriodePeriode(ciblerealisation.getIduniteorganisation().getIduniteorganisation(),
                    ciblerealisation.getIdsousperiode().getIdperiodecosting().getIdperiodecosting(),
                    ciblerealisation.getIdindicateur().getIdindicateur());

            for (Ciblerealisation cr : crTemps) {
                if (!cr.getIdsousperiode().getPeriodedebut()) {
                    ciblerealisations.add(cr);
                }
            }

            mode = "Edit";
            enabledSelect = true;
            RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void updateRenderedColumn() {
        renderedCible = true;
        renderedPas = false;
    }

    public void generate() {
        try {

            if (modeProjection == 0) {
                signalError("choisir_mode_generation");
                return;
            }

            ut.begin();

            for (Ciblerealisation cr : selectedCrs) {

                int i = 1;
                for (Sousperiodecosting sp : sousperiodecostings) {

                    List<Ciblerealisation> crTemps = ciblerealisationFacadeLocal.findByUnitePeriodeIndicateur(cr.getIduniteorganisation().getIduniteorganisation(), sp.getIdsousperiode(), cr.getIdindicateur().getIdindicateur());

                    if (modeProjection == 1) {
                        if (crTemps.isEmpty()) {

                            Ciblerealisation c = new Ciblerealisation();
                            c.setIdciblerealisation(ciblerealisationFacadeLocal.nextVal());
                            c.setIdindicateur(cr.getIdindicateur());
                            c.setIdperiode(sp.getIdperiode());
                            c.setIdsousperiode(sp);
                            c.setIduniteorganisation(cr.getIduniteorganisation());

                            Double pas = ((cr.getCUnitaireFin() - cr.getCUnitaireDebut()) / (sousperiodecostings.size()));
                            c.setCoutUnitaire(cr.getCUnitaireDebut() + (i * pas));
                            c.setPasCoutUnitaire(pas);
                            c.setCUnitaireFin(cr.getCUnitaireFin());
                            c.setCUnitaireDebut(cr.getCUnitaireDebut());

                            if (cr.getCUnitaireFin() < cr.getCUnitaireDebut()) {
                                c.setCoutUnitaire(cr.getCUnitaireFin());
                                c.setPasCoutUnitaire(0d);
                                c.setCUnitaireFin(cr.getCUnitaireFin());
                            }

                            if (c.getPasCoutUnitaire() < 0d) {
                                c.setPasCoutUnitaire(0d);
                            }
                            ciblerealisationFacadeLocal.create(c);
                        } else {
                            Ciblerealisation c = crTemps.get(0);
                            if (cr.getCUnitaireFin() >= cr.getCUnitaireDebut()) {
                                Double pas = ((cr.getCUnitaireFin() - cr.getCUnitaireDebut()) / (sousperiodecostings.size()));
                                c.setCoutUnitaire(cr.getCUnitaireDebut() + (i * pas));
                                c.setPasCoutUnitaire(pas);
                                if (c.getPasCoutUnitaire() < 0d) {
                                    c.setPasCoutUnitaire(0d);
                                }
                                c.setCUnitaireFin(cr.getCUnitaireFin());
                            } else {
                                c.setCoutUnitaire(cr.getCUnitaireFin());
                                c.setCUnitaireFin(cr.getCUnitaireFin());
                                c.setCUnitaireDebut(cr.getCUnitaireDebut());
                                c.setPasCoutUnitaire(0d);
                            }
                            ciblerealisationFacadeLocal.edit(c);
                        }
                    }
                    i += 1;
                }
                cr.setCoutUnitaire(cr.getCUnitaireDebut());
                ciblerealisationFacadeLocal.edit(cr);
            }
            ut.commit();

            signalSuccess();
        } catch (Exception e) {
            e.printStackTrace();
            signalException(e);
        }
    }

    public Ciblerealisation loadValue(Ciblerealisation cr, Sousperiodecosting spc) {
        Ciblerealisation result = new Ciblerealisation();
        try {
            List<Ciblerealisation> crTemps = ciblerealisationFacadeLocal.findByUnitePeriodeIndicateur(cr.getIduniteorganisation().getIduniteorganisation(), spc.getIdsousperiode(), cr.getIdindicateur().getIdindicateur());
            if (!crTemps.isEmpty()) {
                result = crTemps.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new Ciblerealisation();
        }
        return result;
    }

    public void updateData() {
        try {
            selectedCrs.clear();
            couverturepopulation = new Couverturepopulation();
            sousperiodecosting = new Sousperiodecosting();
            if (periodecosting.getIdperiodecosting() != 0) {
                if (uniteorganisation.getIduniteorganisation() != 0) {

                    List<Couverturepopulation> cps = couverturepopulationFacadeLocal.findByPeriodeCostingUnite(periodecosting.getIdperiodecosting(), uniteorganisation.getIduniteorganisation());
                    if (cps.isEmpty()) {
                        signalError("veuillez_programmer_couverture");
                        return;
                    }

                    sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);

                    List<Sousperiodecosting> spc = sousperiodecostingFacadeLocal.findByPeriodeCosting(periodecosting.getIdperiodecosting());

                    for (Sousperiodecosting temp : spc) {
                        if (temp.getPeriodedebut()) {
                            this.sousperiodecosting = temp;
                            break;
                        }
                    }

                    for (Couverturepopulation temp : cps) {
                        if (temp.getIdperiode().equals(sousperiodecosting.getIdperiode())) {
                            this.couverturepopulation = temp;
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
            selectedCrs.get(index).setCouverture(Math.rint(valeur));
        } catch (Exception e) {
            selectedCrs.get(index).setCouverture(0d);
        }
    }

    public void edit() {
        try {
            if (mode.equals("Edit")) {

                if (ciblerealisation != null) {

                    ut.begin();
                    ciblerealisationFacadeLocal.edit(ciblerealisation);
                    ut.commit();

                    signalSuccess();
                    RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').hide()");
                } else {
                    signalError("not_row_selected");
                }
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
