/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.type_uo_indicateur;

import entities.Indicateur;

import entities.TypestructureIndicateur;
import entities.Typeuniteorganisation;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import org.primefaces.model.DualListModel;
import sessions.IndicateurFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.TypestructureIndicateurFacadeLocal;
import sessions.TypeuniteorganisationFacadeLocal;
import utils.Routine;

/**
 *
 * @author Gervais
 */
public class AbstractTypeUoIndicateurController {

    @EJB
    protected TypestructureIndicateurFacadeLocal typestructureIndicateurFacadeLocal;
    protected List<TypestructureIndicateur> typestructureIndicateurs = new ArrayList<>();

    @EJB
    protected TypeuniteorganisationFacadeLocal typeuniteorganisationFacadeLocal;
    protected Typeuniteorganisation typeuniteorganisation = new Typeuniteorganisation();
    protected List<Typeuniteorganisation> typeuniteorganisations = new ArrayList<>();

    @EJB
    protected IndicateurFacadeLocal indicateurFacadeLocal;
    protected Indicateur indicateur = new Indicateur();
    protected List<Indicateur> indicateurs = new ArrayList<>();
    protected DualListModel<Indicateur> dualIndicateur = new DualListModel<>();

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

    public List<TypestructureIndicateur> getTypestructureIndicateurs() {
        return typestructureIndicateurs;
    }

    public void setTypestructureIndicateurs(List<TypestructureIndicateur> typestructureIndicateurs) {
        this.typestructureIndicateurs = typestructureIndicateurs;
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

    public Indicateur getIndicateur() {
        return indicateur;
    }

    public void setIndicateur(Indicateur indicateur) {
        this.indicateur = indicateur;
    }

    public List<Indicateur> getIndicateurs() {
        return indicateurs;
    }

    public void setIndicateurs(List<Indicateur> indicateurs) {
        this.indicateurs = indicateurs;
    }

    public DualListModel<Indicateur> getDualIndicateur() {
        return dualIndicateur;
    }

    public void setDualIndicateur(DualListModel<Indicateur> dualIndicateur) {
        this.dualIndicateur = dualIndicateur;
    }

    public Routine getRoutine() {
        return routine;
    }

    public void setRoutine(Routine routine) {
        this.routine = routine;
    }

}
