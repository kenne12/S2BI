/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.groupe_indicateur;

import entities.Groupindicateur;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import sessions.GroupindicateurFacadeLocal;
import sessions.MouchardFacadeLocal;
import utils.Routine;

/**
 *
 * @author kenne
 */
public class AbstractGroupeIndicateurController {

    @EJB
    protected GroupindicateurFacadeLocal groupindicateurFacadeLocal;
    protected Groupindicateur groupindicateur = new Groupindicateur();
    protected List<Groupindicateur> groupindicateurs = new ArrayList<>();

    @EJB
    protected MouchardFacadeLocal mouchardFacadeLocal;

    protected Boolean detail = true;
    protected Boolean modifier = true;
    protected Boolean consulter = true;
    protected Boolean imprimer = true;
    protected Boolean supprimer = true;

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

    public Groupindicateur getGroupindicateur() {
        return groupindicateur;
    }

    public void setGroupindicateur(Groupindicateur groupindicateur) {
        this.groupindicateur = groupindicateur;
        modifier = supprimer = detail = groupindicateur == null;
    }

    public List<Groupindicateur> getGroupindicateurs() {
        groupindicateurs = groupindicateurFacadeLocal.findAllNom();
        return groupindicateurs;
    }

    public void setGroupindicateurs(List<Groupindicateur> groupindicateurs) {
        this.groupindicateurs = groupindicateurs;
    }

}
