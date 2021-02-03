package controllers.unite_organisation;

import entities.Niveaupyramide;
import entities.Typeuniteorganisation;
import entities.Uniteorganisation;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import sessions.MouchardFacadeLocal;
import sessions.NiveaupyramideFacadeLocal;
import sessions.TypeuniteorganisationFacadeLocal;
import sessions.UniteorganisationFacadeLocal;
import utils.Routine;

public class AbstractUniteOrganisationController {

    @EJB
    protected UniteorganisationFacadeLocal uniteorganisationFacadeLocal;
    protected Uniteorganisation uniteorganisation = new Uniteorganisation();
    protected List<Uniteorganisation> uniteorganisations = new ArrayList<>();

    protected Uniteorganisation uniteorganisationParent = new Uniteorganisation();
    protected List<Uniteorganisation> uniteorganisationParents = new ArrayList<>();

    @EJB
    protected TypeuniteorganisationFacadeLocal typeuniteorganisationFacadeLocal;
    protected Typeuniteorganisation typeuniteorganisation = new Typeuniteorganisation();
    protected List<Typeuniteorganisation> typeuniteorganisations = new ArrayList<>();

    @EJB
    protected NiveaupyramideFacadeLocal niveaupyramideFacadeLocal;
    protected Niveaupyramide niveaupyramide = new Niveaupyramide();
    protected List<Niveaupyramide> niveaupyramides = new ArrayList<>();

    @EJB
    protected MouchardFacadeLocal mouchardFacadeLocal;

    protected Routine routine = new Routine();

    protected Boolean detail = true;
    protected Boolean modifier = true;
    protected Boolean consulter = true;
    protected Boolean imprimer = true;
    protected Boolean supprimer = true;

    protected String mode = "";

    public Boolean getDetail() {
        return this.detail;
    }

    public void setDetail(Boolean detail) {
        this.detail = detail;
    }

    public Boolean getModifier() {
        return this.modifier;
    }

    public void setModifier(Boolean modifier) {
        this.modifier = modifier;
    }

    public Boolean getConsulter() {
        return this.consulter;
    }

    public void setConsulter(Boolean consulter) {
        this.consulter = consulter;
    }

    public Boolean getImprimer() {
        return this.imprimer;
    }

    public void setImprimer(Boolean imprimer) {
        this.imprimer = imprimer;
    }

    public Boolean getSupprimer() {
        return this.supprimer;
    }

    public void setSupprimer(Boolean supprimer) {
        this.supprimer = supprimer;
    }

    public Routine getRoutine() {
        return this.routine;
    }

    public void setRoutine(Routine routine) {
        this.routine = routine;
    }

    public Uniteorganisation getUniteorganisation() {
        return uniteorganisation;
    }

    public void setUniteorganisation(Uniteorganisation uniteorganisation) {
        this.uniteorganisation = uniteorganisation;
        modifier = supprimer = detail = uniteorganisation == null;
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

    public Uniteorganisation getUniteorganisationParent() {
        return uniteorganisationParent;
    }

    public void setUniteorganisationParent(Uniteorganisation uniteorganisationParent) {
        this.uniteorganisationParent = uniteorganisationParent;
    }

    public List<Uniteorganisation> getUniteorganisationParents() {
        try {
            uniteorganisationParents = uniteorganisationFacadeLocal.findParentOrganisation();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return uniteorganisationParents;
    }

    public void setUniteorganisationParents(List<Uniteorganisation> uniteorganisationParents) {
        this.uniteorganisationParents = uniteorganisationParents;
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

    public Niveaupyramide getNiveaupyramide() {
        return niveaupyramide;
    }

    public void setNiveaupyramide(Niveaupyramide niveaupyramide) {
        this.niveaupyramide = niveaupyramide;
    }

    public List<Niveaupyramide> getNiveaupyramides() {
        niveaupyramides = niveaupyramideFacadeLocal.findAllNumero();
        return niveaupyramides;
    }

    public void setNiveaupyramides(List<Niveaupyramide> niveaupyramides) {
        this.niveaupyramides = niveaupyramides;
    }

}
