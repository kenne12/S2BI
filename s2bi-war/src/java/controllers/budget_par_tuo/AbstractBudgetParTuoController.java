/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.budget_par_tuo;

import entities.Budget;
import entities.Devise;
import entities.Indicateur;
import entities.Periodecosting;
import entities.Sousperiodecosting;
import entities.Typeuniteorganisation;
import entities.Uniteorganisation;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.transaction.UserTransaction;
import sessions.BudgetFacadeLocal;
import sessions.DeviseFacadeLocal;
import sessions.DevisePeriodeFacadeLocal;
import sessions.IndicateurFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.PeriodecostingFacadeLocal;
import sessions.SousperiodecostingFacadeLocal;
import sessions.TypeuniteorganisationFacadeLocal;
import sessions.UniteorganisationFacadeLocal;
import utils.Routine;
import utils.SessionMBean;

/**
 *
 * @author kenne
 */
public class AbstractBudgetParTuoController {

    @Resource
    protected UserTransaction ut;

    @EJB
    protected BudgetFacadeLocal budgetFacadeLocal;
    protected List<Budget> selectedBudgets = new ArrayList<>();

    @EJB
    protected IndicateurFacadeLocal indicateurFacadeLocal;
    protected List<Indicateur> indicateurs = new ArrayList<>();

    @EJB
    protected TypeuniteorganisationFacadeLocal typeuniteorganisationFacadeLocal;
    protected Typeuniteorganisation typeuniteorganisation = new Typeuniteorganisation();
    protected List<Typeuniteorganisation> typeuniteorganisations = new ArrayList<>();

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
    protected DeviseFacadeLocal deviseFacadeLocal;
    protected Devise devise = new Devise();
    protected List<Devise> devises = new ArrayList<>();

    @EJB
    protected DevisePeriodeFacadeLocal devisePeriodeFacadeLocal;

    @EJB
    protected MouchardFacadeLocal mouchardFacadeLocal;

    protected Boolean detail = true;
    protected Boolean modifier = true;
    protected Boolean consulter = true;
    protected Boolean imprimer = true;
    protected Boolean supprimer = true;

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

    public Sousperiodecosting getSousperiodecosting() {
        return sousperiodecosting;
    }

    public void setSousperiodecosting(Sousperiodecosting sousperiodecosting) {
        this.sousperiodecosting = sousperiodecosting;
    }

    public List<Sousperiodecosting> getSousperiodecostings() {
        return sousperiodecostings;
    }

    public void setSousperiodecostings(List<Sousperiodecosting> sousperiodecostings) {
        this.sousperiodecostings = sousperiodecostings;
    }

    public Integer getModeProjection() {
        return modeProjection;
    }

    public void setModeProjection(Integer modeProjection) {
        this.modeProjection = modeProjection;
    }

    public List<Budget> getSelectedBudgets() {
        return selectedBudgets;
    }

    public void setSelectedBudgets(List<Budget> selectedBudgets) {
        this.selectedBudgets = selectedBudgets;
    }

    public Typeuniteorganisation getTypeuniteorganisation() {
        return typeuniteorganisation;
    }

    public void setTypeuniteorganisation(Typeuniteorganisation typeuniteorganisation) {
        this.typeuniteorganisation = typeuniteorganisation;
    }

    public List<Typeuniteorganisation> getTypeuniteorganisations() {
        typeuniteorganisations = typeuniteorganisationFacadeLocal.findAllNom();
        return typeuniteorganisations;
    }

    public void setTypeuniteorganisations(List<Typeuniteorganisation> typeuniteorganisations) {
        this.typeuniteorganisations = typeuniteorganisations;
    }

    public Devise getDevise() {
        return devise;
    }

    public void setDevise(Devise devise) {
        this.devise = devise;
    }

    public List<Devise> getDevises() {
        return devises;
    }

    public void setDevises(List<Devise> devises) {
        this.devises = devises;
    }

}
