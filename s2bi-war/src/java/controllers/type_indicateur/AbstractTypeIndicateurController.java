/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.type_indicateur;

import entities.Typeindicateur;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import sessions.MouchardFacadeLocal;
import sessions.TypeindicateurFacadeLocal;
import utils.Routine;

/**
 *
 * @author kenne
 */
public class AbstractTypeIndicateurController {

    @EJB
    protected TypeindicateurFacadeLocal typeindicateurFacadeLocal;
    protected Typeindicateur typeindicateur = new Typeindicateur();
    protected List<Typeindicateur> typeindicateurs = new ArrayList<>();

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

    public Typeindicateur getTypeindicateur() {
        return typeindicateur;
    }

    public void setTypeindicateur(Typeindicateur typeindicateur) {
        this.typeindicateur = typeindicateur;
        modifier = supprimer = detail = typeindicateur == null;
    }

    public List<Typeindicateur> getTypeindicateurs() {
        typeindicateurs = typeindicateurFacadeLocal.findAllNom();
        return typeindicateurs;
    }

    public void setTypeindicateurs(List<Typeindicateur> typeindicateurs) {
        this.typeindicateurs = typeindicateurs;
    }

}
