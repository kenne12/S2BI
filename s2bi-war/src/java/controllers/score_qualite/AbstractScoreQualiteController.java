/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.score_qualite;

import entities.Ciblerealisation;
import entities.Couverturepopulation;
import entities.Indicateur;
import entities.LigneScoreEquite;
import entities.Periodecosting;
import entities.RubriqueScoreQualite;
import entities.Sousperiodecosting;
import entities.Uniteorganisation;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.transaction.UserTransaction;
import sessions.BudgetFacadeLocal;
import sessions.CiblerealisationFacadeLocal;
import sessions.CouverturepopulationFacadeLocal;
import sessions.FinancementFacadeLocal;
import sessions.FinancementbudgetFacadeLocal;
import sessions.IndicateurFacadeLocal;
import sessions.LigneScoreEquiteFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.PeriodecostingFacadeLocal;
import sessions.RubriqueScoreQualiteFacadeLocal;
import sessions.SousperiodecostingFacadeLocal;
import sessions.UniteorganisationFacadeLocal;
import utils.Routine;
import utils.SessionMBean;

/**
 *
 * @author kenne
 */
public class AbstractScoreQualiteController {

    @Resource
    protected UserTransaction ut;

    @EJB
    protected LigneScoreEquiteFacadeLocal ligneScoreEquiteFacadeLocal;
    protected List<LigneScoreEquite> ligneScoreEquites = new ArrayList<>();
    protected List<LigneScoreEquite> selectedScQs = new ArrayList<>();
    protected LigneScoreEquite ligneScoreEquite = new LigneScoreEquite();

    @EJB
    protected RubriqueScoreQualiteFacadeLocal rubriqueScoreQualiteFacadeLocal;
    protected List<RubriqueScoreQualite> rubriqueScoreQualites = new ArrayList<>();

    @EJB
    protected CiblerealisationFacadeLocal ciblerealisationFacadeLocal;
    protected Ciblerealisation ciblerealisation = new Ciblerealisation();
    protected List<Ciblerealisation> ciblerealisations = new ArrayList<>();
    protected List<Ciblerealisation> selectedCrs = new ArrayList<>();

    @EJB
    protected IndicateurFacadeLocal indicateurFacadeLocal;
    protected List<Indicateur> indicateurs = new ArrayList<>();

    @EJB
    protected CouverturepopulationFacadeLocal couverturepopulationFacadeLocal;
    protected Couverturepopulation couverturepopulation = new Couverturepopulation();
    protected List<Couverturepopulation> couverturepopulations = new ArrayList<>();
    protected List<Couverturepopulation> selecteds = new ArrayList<>();

    @EJB
    protected UniteorganisationFacadeLocal uniteorganisationFacadeLocal;
    protected Uniteorganisation uniteorganisation = new Uniteorganisation();
    protected List<Uniteorganisation> uniteorganisations = new ArrayList<>();

    @EJB
    protected PeriodecostingFacadeLocal periodecostingFacadeLocal;
    protected Periodecosting periodecosting = SessionMBean.getPeriodeCosting();
    protected List<Periodecosting> periodecostings = new ArrayList<>();

    @EJB
    protected SousperiodecostingFacadeLocal sousperiodecostingFacadeLocal;
    protected Sousperiodecosting sousperiodecosting = new Sousperiodecosting();
    protected List<Sousperiodecosting> sousperiodecostings = new ArrayList<>();

    @EJB
    protected BudgetFacadeLocal budgetFacadeLocal;
    
    @EJB
    protected FinancementFacadeLocal financementFacadeLocal;
    
    @EJB
    protected FinancementbudgetFacadeLocal financementbudgetFacadeLocal;

    @EJB
    protected MouchardFacadeLocal mouchardFacadeLocal;

    protected Boolean detail = true;
    protected Boolean modifier = true;
    protected Boolean consulter = true;
    protected Boolean imprimer = true;
    protected Boolean supprimer = true;

    protected boolean enabledSelect = false;

    protected boolean renderedPas = true;
    protected boolean renderedCible = true;

    protected Routine routine = new Routine();

    protected String mode = "";
    protected Integer modeProjection = 0;

    public Boolean getDetail() {
        return detail;
    }

    public void setDetail(Boolean detail) {
        this.detail = detail;
    }

    public Boolean getModifier() {
        return modifier;
    }

    public void setModifier(Boolean modifier) {
        this.modifier = modifier;
    }

    public Boolean getConsulter() {
        return consulter;
    }

    public void setConsulter(Boolean consulter) {
        this.consulter = consulter;
    }

    public void setImprimer(Boolean imprimer) {
        this.imprimer = imprimer;
    }

    public Boolean getSupprimer() {
        return supprimer;
    }

    public void setSupprimer(Boolean supprimer) {
        this.supprimer = supprimer;
    }

    public Routine getRoutine() {
        return routine;
    }

    public Periodecosting getPeriodecosting() {
        return periodecosting;
    }

    public void setPeriodecosting(Periodecosting periodecosting) {
        this.periodecosting = periodecosting;
    }

    public List<Periodecosting> getPeriodecostings() {
        periodecostings = SessionMBean.getPeriodeCostings();
        return periodecostings;
    }

    public void setPeriodecostings(List<Periodecosting> periodecostings) {
        this.periodecostings = periodecostings;
    }

    public boolean isEnabledSelect() {
        return enabledSelect;
    }

    public void setEnabledSelect(boolean enabledSelect) {
        this.enabledSelect = enabledSelect;
    }

    public Couverturepopulation getCouverturepopulation() {
        return couverturepopulation;
    }

    public void setCouverturepopulation(Couverturepopulation couverturepopulation) {
        this.couverturepopulation = couverturepopulation;
    }

    public List<Couverturepopulation> getCouverturepopulations() {
        return couverturepopulations;
    }

    public void setCouverturepopulations(List<Couverturepopulation> couverturepopulations) {
        this.couverturepopulations = couverturepopulations;
    }

    public Uniteorganisation getUniteorganisation() {
        return uniteorganisation;
    }

    public void setUniteorganisation(Uniteorganisation uniteorganisation) {
        this.uniteorganisation = uniteorganisation;
    }

    public List<Uniteorganisation> getUniteorganisations() {
        try {
            uniteorganisations = uniteorganisationFacadeLocal.findAllRange();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return uniteorganisations;
    }

    public void setUniteorganisations(List<Uniteorganisation> uniteorganisations) {
        this.uniteorganisations = uniteorganisations;
    }

    public List<Ciblerealisation> getCiblerealisations() {
        try {
            ciblerealisations = ciblerealisationFacadeLocal.findAllBase();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ciblerealisations;
    }

    public void setCiblerealisations(List<Ciblerealisation> ciblerealisations) {
        this.ciblerealisations = ciblerealisations;
    }

    public Sousperiodecosting getSousperiodecosting() {
        return sousperiodecosting;
    }

    public void setSousperiodecosting(Sousperiodecosting sousperiodecosting) {
        this.sousperiodecosting = sousperiodecosting;
    }

    public List<Ciblerealisation> getSelectedCrs() {
        return selectedCrs;
    }

    public void setSelectedCrs(List<Ciblerealisation> selectedCrs) {
        this.selectedCrs = selectedCrs;
    }

    public Ciblerealisation getCiblerealisation() {
        return ciblerealisation;
    }

    public void setCiblerealisation(Ciblerealisation ciblerealisation) {
        this.ciblerealisation = ciblerealisation;
        detail = consulter = modifier = supprimer = ciblerealisation == null;
    }

    public List<Sousperiodecosting> getSousperiodecostings() {
        return sousperiodecostings;
    }

    public void setSousperiodecostings(List<Sousperiodecosting> sousperiodecostings) {
        this.sousperiodecostings = sousperiodecostings;
    }

    public boolean isRenderedPas() {
        return renderedPas;
    }

    public void setRenderedPas(boolean renderedPas) {
        this.renderedPas = renderedPas;
    }

    public boolean isRenderedCible() {
        return renderedCible;
    }

    public void setRenderedCible(boolean renderedCible) {
        this.renderedCible = renderedCible;
    }

    public Integer getModeProjection() {
        return modeProjection;
    }

    public void setModeProjection(Integer modeProjection) {
        this.modeProjection = modeProjection;
    }

    public List<LigneScoreEquite> getLigneScoreEquites() {
        return ligneScoreEquites;
    }

    public void setLigneScoreEquites(List<LigneScoreEquite> ligneScoreEquites) {
        this.ligneScoreEquites = ligneScoreEquites;
    }

    public LigneScoreEquite getLigneScoreEquite() {
        return ligneScoreEquite;
    }

    public void setLigneScoreEquite(LigneScoreEquite ligneScoreEquite) {
        this.ligneScoreEquite = ligneScoreEquite;
    }

    public List<LigneScoreEquite> getSelectedScQs() {
        return selectedScQs;
    }

    public void setSelectedScQs(List<LigneScoreEquite> selectedScQs) {
        this.selectedScQs = selectedScQs;
    }

}
