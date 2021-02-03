/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.type_uo_indicateur;

import entities.Indicateur;
import entities.TypestructureIndicateur;
import entities.Typeuniteorganisation;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.context.RequestContext;
import utils.JsfUtil;
import utils.Utilitaires;

/**
 *
 * @author Gervais
 */
@ManagedBean
@ViewScoped
public class TypeUoIndicateurController extends AbstractTypeUoIndicateurController implements TypeUoIndicateurInterfaceController, Serializable {

    @PostConstruct
    private void initAcces() {

    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(31L)) {
                signalError("acces_refuse");
                return;
            }
            dualIndicateur.getSource().clear();
            dualIndicateur.getTarget().clear();
            typeuniteorganisation = new Typeuniteorganisation();
            RequestContext.getCurrentInstance().execute("PF('AccesCreerDialog').show()");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void viewAccess(Typeuniteorganisation t) {
        try {
            this.typeuniteorganisation = t;
            typestructureIndicateurs = typestructureIndicateurFacadeLocal.findByTypeUo(typeuniteorganisation.getIdtypeuniteorganisation());
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Echec");
        }
    }

    public void handleTypeChange() {
        dualIndicateur.getSource().clear();
        dualIndicateur.getTarget().clear();
        try {
            if (typeuniteorganisation.getIdtypeuniteorganisation() != null) {

                typeuniteorganisation = typeuniteorganisationFacadeLocal.find(typeuniteorganisation.getIdtypeuniteorganisation());

                List<TypestructureIndicateur> tsiTemps = typestructureIndicateurFacadeLocal.findByTypeUo(typeuniteorganisation.getIdtypeuniteorganisation());
                if (tsiTemps.isEmpty()) {
                    dualIndicateur.setSource(indicateurFacadeLocal.findAllRange());
                } else {

                    List<Indicateur> indicateurTarget = new ArrayList<>();

                    for (TypestructureIndicateur t : tsiTemps) {
                        indicateurTarget.add(t.getIdindicateur());
                    }

                    dualIndicateur.getTarget().addAll(indicateurTarget);
                    dualIndicateur.getSource().addAll(indicateurFacadeLocal.findAllRange());
                    dualIndicateur.getSource().removeAll(indicateurTarget);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void save() {
        try {
            if (typeuniteorganisation.getIdtypeuniteorganisation() != null) {
                typeuniteorganisation = typeuniteorganisationFacadeLocal.find(typeuniteorganisation.getIdtypeuniteorganisation());

                for (Indicateur i : dualIndicateur.getSource()) {
                    TypestructureIndicateur t = typestructureIndicateurFacadeLocal.findByTypeUoIndicateur(typeuniteorganisation.getIdtypeuniteorganisation(), i.getIdindicateur());
                    if (t != null) {
                        typestructureIndicateurFacadeLocal.remove(t);                        
                    }
                }

                for (Indicateur i : dualIndicateur.getTarget()) {
                    TypestructureIndicateur t = typestructureIndicateurFacadeLocal.findByTypeUoIndicateur(typeuniteorganisation.getIdtypeuniteorganisation(), i.getIdindicateur());
                    if (t == null) {
                        t = new TypestructureIndicateur();
                        t.setIdTypestructureIndicateur(typestructureIndicateurFacadeLocal.nextVal());
                        t.setIdindicateur(i);
                        t.setIdtypestructure(typeuniteorganisation);
                        typestructureIndicateurFacadeLocal.create(t);                        
                    }
                }

                signalSuccess();
                RequestContext.getCurrentInstance().execute("PF('AccesCreerDialog').hide()");

            } else {
                signalError("control_formulaire");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void signalError(String chaine) {
        RequestContext.getCurrentInstance().execute("PF('AjaxNotifyDialog').hide()");
        routine.feedBack("information", "/resources/tool_images/warning.jpeg", routine.localizeMessage(chaine));
        RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
    }

    public void signalSuccess() {
        RequestContext.getCurrentInstance().execute("PF('AjaxNotifyDialog').hide()");
        routine.feedBack("information", "/resources/tool_images/success.png", routine.localizeMessage("operation_reussie"));
        RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
    }

    public void signalException(Exception e) {
        RequestContext.getCurrentInstance().execute("PF('AjaxNotifyDialog').hide()");
        routine.catchException(e, routine.localizeMessage("erreur_execution"));
        RequestContext.getCurrentInstance().execute("PF('NotifyDialog1').show()");
    }

}
