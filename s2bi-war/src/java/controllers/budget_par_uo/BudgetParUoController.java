/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.budget_par_uo;

import entities.Budget;
import entities.Devise;
import entities.DevisePeriode;
import entities.Sousperiodecosting;
import entities.Uniteorganisation;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.context.RequestContext;
import utils.JsfUtil;
import utils.Utilitaires;

/**
 *
 * @author kenne
 */
@ManagedBean
@ViewScoped
public class BudgetParUoController extends AbstractBudgetParUoController implements Serializable {

    /**
     * Creates a new instance of BudgetController
     */
    public BudgetParUoController() {
    }

    @PostConstruct
    private void init() {
        uniteorganisation = new Uniteorganisation();
        uniteorganisation.setIduniteorganisation(0);
        typeuniteorganisation.setIdtypeuniteorganisation(0);

        try {
            devises = deviseFacadeLocal.findAllNom();
            for (Devise d : devises) {
                if (d.getDefaultM()) {
                    devise = d;
                    break;
                }
            }

            if (periodecosting != null) {
                sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String loadValue(Uniteorganisation u, Sousperiodecosting s) {
        try {
            if (typeuniteorganisation.getIdtypeuniteorganisation() != 0) {

                DevisePeriode dp = null;
                if (devise.getIddevise() != null) {
                    dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
                }

                List<Budget> budgetTemps = budgetFacadeLocal.findByUniteSousperiode(u.getIduniteorganisation(), s.getIdsousperiode());
                if (!budgetTemps.isEmpty()) {
                    Double resultat = 0d;
                    for (Budget b : budgetTemps) {
                        resultat += b.getTotal();
                    }
                    if (dp != null) {
                        if (dp.getValeur() != 1) {
                            return formatStingMoney(Utilitaires.arrondiNDecimales((resultat / dp.getValeur()), 2));
                        }
                        return formatStingMoney(resultat.intValue());
                    }
                    if (devise.getCoutUnitaireDefault() != 1) {
                        return formatStingMoney(Utilitaires.arrondiNDecimales((resultat / devise.getCoutUnitaireDefault()), 2));
                    }
                    return formatStingMoney(resultat.intValue());
                }
                return "";
            }
            return "";
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public String loadValue1(Uniteorganisation u) {
        try {
            if (periodecosting.getIdperiodecosting() != 0) {
                List<Budget> budgetTemps = budgetFacadeLocal.findByUnitePeriodecosting(u.getIduniteorganisation(), periodecosting.getIdperiodecosting());
                if (!budgetTemps.isEmpty()) {
                    Double resultat = 0d;
                    for (Budget b : budgetTemps) {
                        resultat += b.getTotal();
                    }
                    if (devise.getCoutUnitaireDefault() != 1) {
                        return formatStingMoney(Utilitaires.arrondiNDecimales(resultat / devise.getCoutUnitaireDefault(), 2));
                    }
                    return formatStingMoney(resultat.intValue());
                }
                return "";
            }
            return "";
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public String loadValue() {
        try {
            if (periodecosting.getIdperiodecosting() != 0) {
                if (typeuniteorganisation.getIdtypeuniteorganisation() != 0) {
                    List<Budget> budgetTemps = budgetFacadeLocal.findByTypeUoPeriodecosting(typeuniteorganisation.getIdtypeuniteorganisation(), periodecosting.getIdperiodecosting());
                    if (!budgetTemps.isEmpty()) {
                        Double resultat = 0d;
                        for (Budget b : budgetTemps) {
                            resultat += b.getTotal();
                        }
                        if (devise.getCoutUnitaireDefault() != 1) {
                            return formatStingMoney(Utilitaires.arrondiNDecimales(resultat / devise.getCoutUnitaireDefault(), 2));
                        }
                        return formatStingMoney(resultat.intValue());
                    }
                    return "";
                }
                return "";
            }
            return "";
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public String formatStingMoney(Double value) {
        if (value == null) {
            return "";
        }
        return JsfUtil.formaterStringMoney(value);
    }

    public String formatStingMoney(Integer value) {
        if (value == null) {
            return "";
        }
        return JsfUtil.formaterStringMoney(value);
    }

    public String sommeBudget(Sousperiodecosting s) {
        String result = "";
        try {
            if (typeuniteorganisation.getIdtypeuniteorganisation() != 0) {

                DevisePeriode dp = null;
                if (devise.getIddevise() != null) {
                    dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
                }

                List<Budget> budgetTemps = budgetFacadeLocal.findByTypeUoSousperiode(typeuniteorganisation.getIdtypeuniteorganisation(), s.getIdsousperiode());
                if (!budgetTemps.isEmpty()) {
                    Double somme = 0d;
                    for (Budget b : budgetTemps) {
                        somme += b.getTotal();
                    }
                    if (dp != null) {
                        if (dp.getValeur() != 1) {
                            return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / dp.getValeur(), 2));
                        }
                        return JsfUtil.formaterStringMoney(somme.intValue());
                    }
                    if (devise.getCoutUnitaireDefault() != 1) {
                        return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / devise.getCoutUnitaireDefault(), 2));
                    }
                    return JsfUtil.formaterStringMoney(somme.intValue());
                }
                return null;
            }
            return null;
        } catch (Exception e) {
            result = null;
        }
        return result;
    }

    public void updateData() {
        try {
            selectedBudgets.clear();
            uniteorganisations.clear();
            sousperiodecostings.clear();
            if (periodecosting.getIdperiodecosting() != 0) {
                if (typeuniteorganisation.getIdtypeuniteorganisation() != 0) {

                    uniteorganisations = uniteorganisationFacadeLocal.findByTypeUo(typeuniteorganisation.getIdtypeuniteorganisation());

                    sousperiodecostings.clear();
                    sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);

                    selectedBudgets.clear();
                    for (Uniteorganisation u : uniteorganisations) {
                        Budget b = new Budget();
                        b.setIduniteorganisation(u);
                        selectedBudgets.add(b);
                    }
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateDevise() {
        try {
            if (devise.getIddevise() != null) {
                devise = deviseFacadeLocal.find(devise.getIddevise());
            }
        } catch (Exception e) {
            e.printStackTrace();
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
