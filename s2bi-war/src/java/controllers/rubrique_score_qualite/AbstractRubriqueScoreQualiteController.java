/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.rubrique_score_qualite;

import entities.RubriqueScoreQualite;
import entities.Sourcefinancement;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import sessions.MouchardFacadeLocal;
import sessions.RubriqueScoreQualiteFacadeLocal;
import sessions.SourcefinancementFacadeLocal;
import utils.Routine;

/**
 *
 * @author kenne
 */
public class AbstractRubriqueScoreQualiteController {

    @EJB
    protected RubriqueScoreQualiteFacadeLocal rubriqueScoreQualiteFacadeLocal;
    protected RubriqueScoreQualite rubriqueScoreQualite = new RubriqueScoreQualite();
    protected List<RubriqueScoreQualite> rubriqueScoreQualites = new ArrayList<>();

    @EJB
    protected SourcefinancementFacadeLocal sourcefinancementFacadeLocal;
    protected Sourcefinancement sourcefinancement = new Sourcefinancement();
    protected List<Sourcefinancement> sourcefinancements = new ArrayList<>();

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

    public Sourcefinancement getSourcefinancement() {
        return sourcefinancement;
    }

    public void setSourcefinancement(Sourcefinancement sourcefinancement) {
        this.sourcefinancement = sourcefinancement;
        detail = consulter = modifier = supprimer = sourcefinancement == null;
    }

    public List<Sourcefinancement> getSourcefinancements() {
        sourcefinancements = sourcefinancementFacadeLocal.findAllNom();
        return sourcefinancements;
    }

    public void setSourcefinancements(List<Sourcefinancement> sourcefinancements) {
        this.sourcefinancements = sourcefinancements;
    }

    public RubriqueScoreQualite getRubriqueScoreQualite() {
        return rubriqueScoreQualite;
    }

    public void setRubriqueScoreQualite(RubriqueScoreQualite rubriqueScoreQualite) {
        this.rubriqueScoreQualite = rubriqueScoreQualite;
    }

    public List<RubriqueScoreQualite> getRubriqueScoreQualites() {
        return rubriqueScoreQualites;
    }

    public void setRubriqueScoreQualites(List<RubriqueScoreQualite> rubriqueScoreQualites) {
        this.rubriqueScoreQualites = rubriqueScoreQualites;
    }

}
