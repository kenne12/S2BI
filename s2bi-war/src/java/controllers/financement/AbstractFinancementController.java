/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.financement;

import entities.Bailleurfond;
import entities.Financement;
import entities.Periodecosting;
import entities.Sousperiodecosting;
import entities.Typeuniteorganisation;
import entities.Uniteorganisation;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.transaction.UserTransaction;
import sessions.BailleurfondFacadeLocal;
import sessions.BudgetFacadeLocal;
import sessions.CiblerealisationFacadeLocal;
import sessions.CouverturepopulationFacadeLocal;
import sessions.FinancementFacadeLocal;
import sessions.FinancementbudgetFacadeLocal;
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
public class AbstractFinancementController {

    @Resource
    protected UserTransaction ut;

    @EJB
    protected FinancementFacadeLocal financementFacadeLocal;
    protected Financement financement = new Financement();
    protected List<Financement> financements = new ArrayList<>();
    protected List<Financement> selectedFinancements = new ArrayList<>();

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
    protected TypeuniteorganisationFacadeLocal typeuniteorganisationFacadeLocal;
    protected Typeuniteorganisation typeuniteorganisation = new Typeuniteorganisation();
    protected List<Typeuniteorganisation> typeuniteorganisations = new ArrayList<>();

    @EJB
    protected BailleurfondFacadeLocal bailleurfondFacadeLocal;
    protected Bailleurfond bailleurfond = new Bailleurfond();
    protected List<Bailleurfond> bailleurfonds = new ArrayList<>();

    @EJB
    protected BudgetFacadeLocal budgetFacadeLocal;

    @EJB
    protected CiblerealisationFacadeLocal ciblerealisationFacadeLocal;

    @EJB
    protected FinancementbudgetFacadeLocal financementbudgetFacadeLocal;
    
    @EJB
    protected CouverturepopulationFacadeLocal couverturepopulationFacadeLocal;

    @EJB
    protected MouchardFacadeLocal mouchardFacadeLocal;

    protected Boolean detail = true;
    protected Boolean modifier = true;
    protected Boolean consulter = true;
    protected Boolean imprimer = true;
    protected Boolean supprimer = true;

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

    public Bailleurfond getBailleurfond() {
        return bailleurfond;
    }

    public void setBailleurfond(Bailleurfond bailleurfond) {
        this.bailleurfond = bailleurfond;
    }

    public List<Bailleurfond> getBailleurfonds() {
        return bailleurfonds;
    }

    public void setBailleurfonds(List<Bailleurfond> bailleurfonds) {
        this.bailleurfonds = bailleurfonds;
    }

    public Financement getFinancement() {
        return financement;
    }

    public void setFinancement(Financement financement) {
        this.financement = financement;
        detail = consulter = modifier = supprimer = financement == null;
    }

    public List<Financement> getFinancements() {
        financements = financementFacadeLocal.findAllRange();
        return financements;
    }

    public void setFinancements(List<Financement> financements) {
        this.financements = financements;
    }

    public List<Financement> getSelectedFinancements() {
        return selectedFinancements;
    }

    public void setSelectedFinancements(List<Financement> selectedFinancements) {
        this.selectedFinancements = selectedFinancements;
    }

}
