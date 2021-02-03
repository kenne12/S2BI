/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import entities.Mouchard;
import entities.Periodecosting;
import entities.UtilisateurCosting;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import sessions.MenuFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.PeriodecostingFacadeLocal;

import sessions.PrivilegeFacadeLocal;
import sessions.UtilisateurCostingFacadeLocal;

/**
 *
 * @author gervais
 */
public class AbstractLoginBean {

    @EJB
    protected UtilisateurCostingFacadeLocal utilisateurCostingFacadeLocal;
    protected List<UtilisateurCosting> utilisateurCostings = new ArrayList<>();

    @EJB
    protected PeriodecostingFacadeLocal periodecostingFacadeLocal;
    protected Periodecosting periodecosting = new Periodecosting();
    protected List<Periodecosting> periodecostings = new ArrayList<>();

    @EJB
    protected MenuFacadeLocal menuFacadeLocal;

    @EJB
    protected PrivilegeFacadeLocal privilegeFacadeLocal;

    @EJB
    protected MouchardFacadeLocal mouchardFacadeLocal;

    protected Mouchard mouchard;

    protected Routine routine = new Routine();

    protected Date date = new Date();

    protected String confirmPassword = "";

    //visibility module
    protected boolean showHibernatePanel = false;
    
    protected String hibernatePassword = "";

    //Session boolean
    protected boolean showSessionPanel = true;

    protected boolean connected = false;

    public boolean isShowHibernatePanel() {
        return showHibernatePanel;
    }

    public void setShowHibernatePanel(boolean showHibernatePanel) {
        this.showHibernatePanel = showHibernatePanel;
    }

    public String getHibernatePassword() {
        return hibernatePassword;
    }

    public void setHibernatePassword(String hibernatePassword) {
        this.hibernatePassword = hibernatePassword;
    }

    public boolean isShowSessionPanel() {
        return showSessionPanel;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Routine getRoutine() {
        return routine;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public List<UtilisateurCosting> getUtilisateurCostings() {
        return utilisateurCostings;
    }

    public void setUtilisateurCostings(List<UtilisateurCosting> utilisateurCostings) {
        this.utilisateurCostings = utilisateurCostings;
    }

    public Periodecosting getPeriodecosting() {
        return periodecosting;
    }

    public void setPeriodecosting(Periodecosting periodecosting) {
        this.periodecosting = periodecosting;
    }

    public List<Periodecosting> getPeriodecostings() {
        return periodecostings;
    }

    public void setPeriodecostings(List<Periodecosting> periodecostings) {
        this.periodecostings = periodecostings;
    }

}
