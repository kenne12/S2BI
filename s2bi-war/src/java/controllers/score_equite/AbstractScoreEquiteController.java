/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.score_equite;

import entities.Couverturepopulation;
import entities.Periodecosting;
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
import sessions.MouchardFacadeLocal;
import sessions.PeriodecostingFacadeLocal;
import sessions.SousperiodecostingFacadeLocal;
import sessions.UniteorganisationFacadeLocal;
import utils.Routine;
import utils.SessionMBean;

/**
 *
 * @author kenne
 */
public class AbstractScoreEquiteController {

    @Resource
    protected UserTransaction ut;

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

    @EJB
    protected CiblerealisationFacadeLocal ciblerealisationFacadeLocal;

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

    protected Integer modeProjection = 0;

    protected boolean enabledSelect = false;

    protected Routine routine = new Routine();

    protected String mode = "";

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
        detail = consulter = modifier = supprimer = couverturepopulation == null;
    }

    public List<Couverturepopulation> getCouverturepopulations() {
        try {
            couverturepopulations = couverturepopulationFacadeLocal.findAllRange();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return couverturepopulations;
    }

    public void setCouverturepopulations(List<Couverturepopulation> couverturepopulations) {
        this.couverturepopulations = couverturepopulations;
    }

    public List<Couverturepopulation> getSelecteds() {
        return selecteds;
    }

    public void setSelecteds(List<Couverturepopulation> selecteds) {
        this.selecteds = selecteds;
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

    public Integer getModeProjection() {
        return modeProjection;
    }

    public void setModeProjection(Integer modeProjection) {
        this.modeProjection = modeProjection;
    }

    public Sousperiodecosting getSousperiodecosting() {
        return sousperiodecosting;
    }

    public void setSousperiodecosting(Sousperiodecosting sousperiodecosting) {
        this.sousperiodecosting = sousperiodecosting;
    }

}
