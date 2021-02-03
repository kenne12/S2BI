/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.type_unite_organisation;

import entities.Typeuniteorganisation;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import sessions.MouchardFacadeLocal;
import sessions.TypeuniteorganisationFacadeLocal;
import utils.Routine;

/**
 *
 * @author kenne
 */
public class AbstractTypeUniteOrganisationController {

    @EJB
    protected TypeuniteorganisationFacadeLocal typeuniteorganisationFacadeLocal;
    protected Typeuniteorganisation typeuniteorganisation = new Typeuniteorganisation();
    protected List<Typeuniteorganisation> typeuniteorganisations = new ArrayList<>();

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

    public Typeuniteorganisation getTypeuniteorganisation() {
        return typeuniteorganisation;
    }

    public void setTypeuniteorganisation(Typeuniteorganisation typeuniteorganisation) {
        this.typeuniteorganisation = typeuniteorganisation;
        detail = consulter = modifier = supprimer = typeuniteorganisation == null;
    }

    public List<Typeuniteorganisation> getTypeuniteorganisations() {
        typeuniteorganisations = typeuniteorganisationFacadeLocal.findAllNom();
        return typeuniteorganisations;
    }

    public void setTypeuniteorganisations(List<Typeuniteorganisation> typeuniteorganisations) {
        this.typeuniteorganisations = typeuniteorganisations;
    }

}
