/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.utilisateur_costing;

import entities.Periodecosting;

import entities.Utilisateur;
import entities.UtilisateurCosting;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import org.primefaces.model.DualListModel;
import sessions.MouchardFacadeLocal;
import sessions.PeriodecostingFacadeLocal;
import sessions.UtilisateurCostingFacadeLocal;
import sessions.UtilisateurFacadeLocal;
import utils.Routine;

/**
 *
 * @author Gervais
 */
public class AbstractUtilisateurCostingController {

    @EJB
    protected UtilisateurCostingFacadeLocal utilisateurCostingFacadeLocal;
    protected List<UtilisateurCosting> utilisateurCostings = new ArrayList<>();


    @EJB
    protected UtilisateurFacadeLocal utilisateurFacadeLocal;
    protected Utilisateur utilisateur = new Utilisateur();
    protected List<Utilisateur> utilisateurs = new ArrayList<>();

    @EJB
    protected PeriodecostingFacadeLocal periodecostingFacadeLocal;
    protected DualListModel<Periodecosting> dualCosting = new DualListModel<>();



    @EJB
    protected MouchardFacadeLocal mouchardFacadeLocal;

    protected Routine routine = new Routine();

    protected String fileName;

    protected boolean detail = true;
    protected boolean supprimer = true;
    protected boolean imprimer = true;

    public boolean isDetail() {
        return detail;
    }

    public boolean isSupprimer() {
        return supprimer;
    }



    public Routine getRoutine() {
        return routine;
    }

    public void setRoutine(Routine routine) {
        this.routine = routine;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public List<Utilisateur> getUtilisateurs() {
        try {
            utilisateurs = utilisateurFacadeLocal.findByActif(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return utilisateurs;
    }

    public void setUtilisateurs(List<Utilisateur> utilisateurs) {
        this.utilisateurs = utilisateurs;
    }

    public DualListModel<Periodecosting> getDualCosting() {
        return dualCosting;
    }

    public void setDualCosting(DualListModel<Periodecosting> dualCosting) {
        this.dualCosting = dualCosting;
    }

    public List<UtilisateurCosting> getUtilisateurCostings() {
        return utilisateurCostings;
    }

    public void setUtilisateurCostings(List<UtilisateurCosting> utilisateurCostings) {
        this.utilisateurCostings = utilisateurCostings;
    }

}
