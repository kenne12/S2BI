/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.projection_devise;

import entities.Devise;
import entities.DevisePeriode;
import entities.Periode;
import entities.Uniteorganisation;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.transaction.UserTransaction;
import sessions.DeviseFacadeLocal;
import sessions.DevisePeriodeFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.PeriodeFacadeLocal;
import utils.Routine;

/**
 *
 * @author kenne
 */
public class AbstractProjectionDeviseController {

    @Resource
    protected UserTransaction ut;

    @EJB
    protected DevisePeriodeFacadeLocal devisePeriodeFacadeLocal;
    protected DevisePeriode devisePeriode = new DevisePeriode();
    protected List<DevisePeriode> devisePeriodes = new ArrayList<>();
    protected List<DevisePeriode> selectedsDp = new ArrayList<>();

    @EJB
    protected PeriodeFacadeLocal periodeFacadeLocal;
    protected Periode periode = new Periode();
    protected List<Uniteorganisation> periodes = new ArrayList<>();

    @EJB
    protected DeviseFacadeLocal deviseFacadeLocal;
    protected Devise devise = new Devise();
    protected List<Devise> devises = new ArrayList<>();

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

    public boolean isEnabledSelect() {
        return enabledSelect;
    }

    public void setEnabledSelect(boolean enabledSelect) {
        this.enabledSelect = enabledSelect;
    }

    public Devise getDevise() {
        return devise;
    }

    public void setDevise(Devise devise) {
        this.devise = devise;
    }

    public List<Devise> getDevises() {
        devises = deviseFacadeLocal.findAllNom();
        return devises;
    }

    public void setDevises(List<Devise> devises) {
        this.devises = devises;
    }

    public Periode getPeriode() {
        return periode;
    }

    public void setPeriode(Periode periode) {
        this.periode = periode;
    }

    public List<Uniteorganisation> getPeriodes() {
        return periodes;
    }

    public void setPeriodes(List<Uniteorganisation> periodes) {
        this.periodes = periodes;
    }

    public DevisePeriode getDevisePeriode() {
        return devisePeriode;
    }

    public void setDevisePeriode(DevisePeriode devisePeriode) {
        this.devisePeriode = devisePeriode;
        detail = consulter = modifier = supprimer = devisePeriode == null;
    }

    public List<DevisePeriode> getDevisePeriodes() {
        devisePeriodes = devisePeriodeFacadeLocal.findAllRange();
        return devisePeriodes;
    }

    public void setDevisePeriodes(List<DevisePeriode> devisePeriodes) {
        this.devisePeriodes = devisePeriodes;
    }

    public List<DevisePeriode> getSelectedsDp() {
        return selectedsDp;
    }

    public void setSelectedsDp(List<DevisePeriode> selectedsDp) {
        this.selectedsDp = selectedsDp;
    }

}
