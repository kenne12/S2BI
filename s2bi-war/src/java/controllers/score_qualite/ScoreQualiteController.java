/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.score_qualite;

import entities.Ciblerealisation;
import entities.Couverturepopulation;
import entities.LigneScoreEquite;
import entities.RubriqueScoreQualite;
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
public class ScoreQualiteController extends AbstractScoreQualiteController implements Serializable {

    /**
     * Creates a new instance of ClientController
     */
    public ScoreQualiteController() {
    }

    @PostConstruct
    private void init() {
        couverturepopulation = new Couverturepopulation();
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(41L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            enabledSelect = false;

            selectedScQs.clear();
            couverturepopulations.clear();

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
            if (ciblerealisation != null) {

                if (!Utilitaires.isAccess(41L)) {
                    signalError("acces_refuse");
                    return;
                }

                ciblerealisations = ciblerealisationFacadeLocal.findByUnitePeriodeIndicateur(ciblerealisation.getIduniteorganisation().getIduniteorganisation(),
                        ciblerealisation.getIdperiode().getIdperiode(),
                        ciblerealisation.getIdindicateur().getIdindicateur());

                mode = "Edit";
                enabledSelect = true;

                RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').show()");
            } else {
                signalError("not_selected_row");
            }
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

            for (LigneScoreEquite lsEq : selectedScQs) {

                int i = 0;
                for (Couverturepopulation cp : couverturepopulations) {

                    List<LigneScoreEquite> lsTemps = ligneScoreEquiteFacadeLocal.findByCouvertureRubrique(cp.getIdcouverturepopulation(), lsEq.getIdrubriqueScore().getIdRubriqueScoreQualite());

                    if (modeProjection == 1) {
                        if (lsTemps.isEmpty()) {

                            LigneScoreEquite l = new LigneScoreEquite();

                            l.setIdLigneScoreEquite(ligneScoreEquiteFacadeLocal.nextVal());
                            l.setIdcouverture(cp);
                            l.setIdrubriqueScore(lsEq.getIdrubriqueScore());
                            l.setIdsousPeriode(cp.getIdsousperiode().getIdsousperiode());

                            Double pas = ((lsEq.getValFin() - lsEq.getValFin()) / (couverturepopulations.size() - 1));
                            l.setPas(pas);
                            l.setValDebut(lsEq.getValDebut());
                            l.setValFin(lsEq.getValFin());
                            l.setValeur(lsEq.getValDebut() + (i * pas));

                            if (lsEq.getValFin() < lsEq.getValDebut()) {
                                l.setValeur(lsEq.getValFin());
                                l.setPas(0d);
                                l.setValFin(lsEq.getValFin());
                            }

                            if (l.getPas() < 0d) {
                                l.setPas(0D);
                            }
                            ligneScoreEquiteFacadeLocal.create(l);
                        } else {
                            LigneScoreEquite l = lsTemps.get(0);
                            if (lsEq.getValFin() >= lsEq.getValDebut()) {
                                Double pas = ((lsEq.getValFin() - lsEq.getValDebut()) / (couverturepopulations.size() - 1));
                                l.setValeur(lsEq.getValDebut() + (i * pas));
                                l.setPas(pas);
                                if (l.getPas() < 0d) {
                                    l.setPas(0d);
                                }
                                l.setValFin(lsEq.getValFin());
                                l.setValDebut(lsEq.getValDebut());
                            } else {
                                l.setValeur(lsEq.getValFin());
                                l.setValFin(lsEq.getValFin());
                                l.setValDebut(lsEq.getValDebut());
                                l.setPas(0d);
                            }
                            ligneScoreEquiteFacadeLocal.edit(l);
                        }
                    }
                    i += 1;
                }
            }

            int conteur = 0;
            for (Couverturepopulation cp : couverturepopulations) {
                List<LigneScoreEquite> lTemps = ligneScoreEquiteFacadeLocal.findByCouverture(cp.getIdcouverturepopulation());
                Double score = 0d;
                for (LigneScoreEquite l : lTemps) {
                    score += l.getValeur();
                }
                cp.setValScoreQualite(score);
                couverturepopulations.get(conteur).setValScoreQualite(score);
                couverturepopulationFacadeLocal.edit(cp);
                conteur++;
            }
            ut.commit();

            List<Sousperiodecosting> spcs = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);
            Utilitaires.generate(ut, uniteorganisation, spcs, budgetFacadeLocal, ciblerealisationFacadeLocal, couverturepopulationFacadeLocal, null, financementFacadeLocal, financementbudgetFacadeLocal);

            signalSuccess();
        } catch (Exception e) {
            e.printStackTrace();
            signalException(e);
        }
    }

    public LigneScoreEquite loadValue(Couverturepopulation cp, RubriqueScoreQualite rcs) {
        LigneScoreEquite result = null;
        try {
            List<LigneScoreEquite> lsETemps = ligneScoreEquiteFacadeLocal.findByCouvertureRubrique(cp.getIdcouverturepopulation(), rcs.getIdRubriqueScoreQualite());
            if (!lsETemps.isEmpty()) {
                result = lsETemps.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new LigneScoreEquite();
        }
        return result;
    }

    public void updateData() {
        try {
            selectedScQs.clear();
            if (periodecosting.getIdperiodecosting() != 0) {
                if (uniteorganisation.getIduniteorganisation() != 0) {

                    couverturepopulations = couverturepopulationFacadeLocal.findByPeriodeCostingUnite(periodecosting.getIdperiodecosting(), uniteorganisation.getIduniteorganisation());
                    sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCosting(periodecosting.getIdperiodecosting());

                    List<LigneScoreEquite> ligneScoreTemps = ligneScoreEquiteFacadeLocal.findByPerioCostingUniteBase(periodecosting.getIdperiodecosting(), uniteorganisation.getIduniteorganisation());

                    if (!couverturepopulations.isEmpty()) {

                        for (Couverturepopulation cps : couverturepopulations) {
                            if (cps.getIdsousperiode().getPeriodedebut()) {
                                couverturepopulation = cps;
                                break;
                            }
                        }

                        if (!ligneScoreTemps.isEmpty() && ligneScoreTemps != null) {
                            selectedScQs.addAll(ligneScoreTemps);
                        } else {
                            List<RubriqueScoreQualite> rTemp = rubriqueScoreQualiteFacadeLocal.findAll();
                            for (RubriqueScoreQualite r : rTemp) {
                                LigneScoreEquite lsQ = new LigneScoreEquite();
                                lsQ.setIdLigneScoreEquite(0L);
                                lsQ.setIdrubriqueScore(r);
                                lsQ.setIdcouverture(couverturepopulation);
                                lsQ.setPas(0D);
                                lsQ.setValDebut(0D);
                                lsQ.setValFin(r.getPoids());
                                lsQ.setValeur(0D);
                                selectedScQs.add(lsQ);
                            }
                        }
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

    public void create() {
        try {
            if (mode.equals("Create")) {

                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                signalSuccess();
            } else {
                ut.begin();

                RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').hide()");
                signalSuccess();
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
