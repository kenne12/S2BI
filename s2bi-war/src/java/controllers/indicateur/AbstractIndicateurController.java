package controllers.indicateur;

import entities.Groupindicateur;
import entities.Indicateur;
import entities.Typeindicateur;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.transaction.UserTransaction;
import sessions.GroupindicateurFacadeLocal;
import sessions.IndicateurFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.PrivilegeFacadeLocal;
import sessions.TypeindicateurFacadeLocal;
import utils.Routine;

public class AbstractIndicateurController {

    @Resource
    protected UserTransaction ut;

    @EJB
    protected IndicateurFacadeLocal indicateurFacadeLocal;
    protected Indicateur indicateur = new Indicateur();
    protected List<Indicateur> indicateurs = new ArrayList<>();

    @EJB
    protected TypeindicateurFacadeLocal typeindicateurFacadeLocal;
    protected Typeindicateur typeindicateur = new Typeindicateur();
    protected List<Typeindicateur> typeindicateurs = new ArrayList<>();

    @EJB
    protected GroupindicateurFacadeLocal groupindicateurFacadeLocal;
    protected List<Groupindicateur> groupindicateurs = new ArrayList<>();
    protected List<Groupindicateur> selectedGroupindicateurs = new ArrayList<>();

    @EJB
    protected MouchardFacadeLocal mouchardFacadeLocal;

    @EJB
    protected PrivilegeFacadeLocal privilegeFacadeLocal;
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

    public Indicateur getIndicateur() {
        return indicateur;
    }

    public void setIndicateur(Indicateur indicateur) {
        this.indicateur = indicateur;
        this.modifier = this.supprimer = this.detail = indicateur == null;
    }

    public List<Indicateur> getIndicateurs() {
        try {
            indicateurs = indicateurFacadeLocal.findAllRange();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return indicateurs;
    }

    public void setIndicateurs(List<Indicateur> indicateurs) {
        this.indicateurs = indicateurs;
    }

    public Typeindicateur getTypeindicateur() {
        return typeindicateur;
    }

    public void setTypeindicateur(Typeindicateur typeindicateur) {
        this.typeindicateur = typeindicateur;
    }

    public List<Typeindicateur> getTypeindicateurs() {
        try {
            typeindicateurs = typeindicateurFacadeLocal.findAllNom();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return typeindicateurs;
    }

    public void setTypeindicateurs(List<Typeindicateur> typeindicateurs) {
        this.typeindicateurs = typeindicateurs;
    }

}
