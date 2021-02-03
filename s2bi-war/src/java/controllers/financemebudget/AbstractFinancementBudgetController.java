/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.financemebudget;

import entities.Bailleurfond;
import entities.Devise;
import entities.Financementbudget;
import entities.Periodecosting;
import entities.Sousperiodecosting;
import entities.Typeuniteorganisation;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.transaction.UserTransaction;
import sessions.BailleurfondFacadeLocal;
import sessions.BudgetFacadeLocal;
import sessions.DeviseFacadeLocal;
import sessions.DevisePeriodeFacadeLocal;
import sessions.FinancementFacadeLocal;
import sessions.FinancementbudgetFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.PeriodecostingFacadeLocal;
import sessions.SousperiodecostingFacadeLocal;
import sessions.TypeuniteorganisationFacadeLocal;
import utils.Routine;
import utils.SessionMBean;

/**
 *
 * @author kenne
 */
public class AbstractFinancementBudgetController {

    @Resource
    protected UserTransaction ut;

    @EJB
    protected FinancementbudgetFacadeLocal financementbudgetFacadeLocal;
    protected Financementbudget financementbudget = new Financementbudget();
    protected List<Financementbudget> selectedfinancementbudgets = new ArrayList<>();

    @EJB
    protected FinancementFacadeLocal financementFacadeLocal;

    @EJB
    protected BudgetFacadeLocal budgetFacadeLocal;

    @EJB
    protected PeriodecostingFacadeLocal periodecostingFacadeLocal;
    protected Periodecosting periodecosting = SessionMBean.getPeriodeCosting();
    protected List<Periodecosting> periodecostings = new ArrayList<>();

    @EJB
    protected SousperiodecostingFacadeLocal sousperiodecostingFacadeLocal;
    protected Sousperiodecosting sousperiodecosting = new Sousperiodecosting();
    protected List<Sousperiodecosting> sousperiodecostings = new ArrayList<>();

    @EJB
    protected TypeuniteorganisationFacadeLocal typeuniteorganisationFacadeLocal;
    protected Typeuniteorganisation typeuniteorganisation = new Typeuniteorganisation();
    protected List<Typeuniteorganisation> typeuniteorganisations = new ArrayList<>();

    @EJB
    protected BailleurfondFacadeLocal bailleurfondFacadeLocal;
    protected Bailleurfond bailleurfond = new Bailleurfond();
    protected List<Bailleurfond> bailleurfonds = new ArrayList<>();

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

    public Bailleurfond getBailleurfond() {
        return bailleurfond;
    }

    public void setBailleurfond(Bailleurfond bailleurfond) {
        this.bailleurfond = bailleurfond;
    }

    public List<Bailleurfond> getBailleurfonds() {
        bailleurfonds = bailleurfondFacadeLocal.findAllNom();
        return bailleurfonds;
    }

    public void setBailleurfonds(List<Bailleurfond> bailleurfonds) {
        this.bailleurfonds = bailleurfonds;
    }

    public Financementbudget getFinancementbudget() {
        detail = consulter = modifier = supprimer = financementbudget == null;
        return financementbudget;

    }

    public void setFinancementbudget(Financementbudget financementbudget) {
        this.financementbudget = financementbudget;
    }

    public List<Financementbudget> getSelectedfinancementbudgets() {
        return selectedfinancementbudgets;
    }

    public void setSelectedfinancementbudgets(List<Financementbudget> selectedfinancementbudgets) {
        this.selectedfinancementbudgets = selectedfinancementbudgets;
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
