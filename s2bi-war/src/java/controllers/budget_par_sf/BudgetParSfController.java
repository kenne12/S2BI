/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.budget_par_sf;

import entities.Bailleurfond;
import entities.Budget;
import entities.Devise;
import entities.DevisePeriode;
import entities.Financementbudget;
import entities.Sousperiodecosting;
import entities.Uniteorganisation;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import org.primefaces.context.RequestContext;
import utils.JsfUtil;
import utils.Utilitaires;

/**
 *
 * @author kenne
 */
@ManagedBean
@SessionScoped
public class BudgetParSfController extends AbstractBudgetParSfController implements Serializable {

    /**
     * Creates a new instance of BudgetController
     */
    public BudgetParSfController() {
    }

    @PostConstruct
    private void init() {
        uniteorganisation = new Uniteorganisation();
        uniteorganisation.setIduniteorganisation(0);
        typeuniteorganisation.setIdtypeuniteorganisation(0);
        try {
            if (periodecosting != null) {
                sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);
            }

            devises = deviseFacadeLocal.findAllNom();
            for (Devise d : devises) {
                if (d.getDefaultM()) {
                    devise = d;
                    break;
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

    public String loadValue(Bailleurfond b, Sousperiodecosting s) {
        try {
            List<Budget> budgets = budgetFacadeLocal.findBySousperiode(s.getIdsousperiode());
            Double budgTemp = 0d;
            for (Budget obj : budgets) {
                budgTemp += obj.getTotal();
            }

            List<Financementbudget> financements = financementbudgetFacadeLocal.findByBailleurSousperiode(b.getIdbailleurfond(), s.getIdsousperiode());
            Double somme = 0d;
            if (!financements.isEmpty()) {
                for (Financementbudget f : financements) {
                    somme += f.getFinancement();
                }
            }

            DevisePeriode dp = null;
            if (devise.getIddevise() != null) {
                dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
            }

            Double pourcentage = (somme / budgTemp) * 100;
            if (dp != null) {
                if (dp.getValeur() != 1D) {
                    somme = somme / dp.getValeur();
                    return formatStingMoney(Utilitaires.arrondiNDecimales(somme, 2)) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
                }
                return formatStingMoney(somme.intValue()) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
            } else {
                if (devise.getCoutUnitaireDefault() != 1D) {
                    somme = somme / devise.getCoutUnitaireDefault();
                    return formatStingMoney(Utilitaires.arrondiNDecimales(somme, 2)) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
                }
                return formatStingMoney(somme.intValue()) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public String loadValue1(Bailleurfond bailleurfond) {
        try {
            if (periodecosting.getIdperiodecosting() != 0) {
                List<Budget> budgets = budgetFacadeLocal.findByPeriodecosting(periodecosting.getIdperiodecosting());
                Double somme = 0d;
                for (Budget obj : budgets) {
                    somme += obj.getTotal();
                }

                List<Financementbudget> budgetTemps = financementbudgetFacadeLocal.findByBailleurPeriode(bailleurfond.getIdbailleurfond(), periodecosting.getIdperiodecosting());
                Double resultat = 0d;
                if (!budgetTemps.isEmpty()) {
                    for (Financementbudget b : budgetTemps) {
                        resultat += b.getFinancement();
                    }
                }

                Double pourcentage = (resultat / somme) * 100;
                if (devise.getCoutUnitaireDefault() != 1D) {
                    resultat = resultat / devise.getCoutUnitaireDefault();
                    return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(resultat, 2)) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
                }
                return formatStingMoney(resultat.intValue()) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
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
                List<Budget> budgetTemps = budgetFacadeLocal.findByPeriodecosting(periodecosting.getIdperiodecosting());
                Double resultat = 0d;
                if (!budgetTemps.isEmpty()) {
                    for (Budget b : budgetTemps) {
                        resultat += b.getTotal();
                    }
                }

                List<Financementbudget> financements = financementbudgetFacadeLocal.findByPeriode(periodecosting.getIdperiodecosting());
                Double financement = 0d;
                if (!financements.isEmpty()) {
                    for (Financementbudget f : financements) {
                        financement += f.getFinancement();
                    }
                }
                Double pourcentage = (financement / resultat) * 100;
                if (devise.getCoutUnitaireDefault() != 1D) {
                    financement = financement / devise.getCoutUnitaireDefault();
                    return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(financement, 2)) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
                }
                return formatStingMoney(financement.intValue()) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
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
            List<Budget> budgetTemps = budgetFacadeLocal.findBySousperiode(s.getIdsousperiode());
            Double somme = 0d;
            if (!budgetTemps.isEmpty()) {
                for (Budget b : budgetTemps) {
                    somme += b.getTotal();
                }
            }

            List<Financementbudget> financements = financementbudgetFacadeLocal.findBySousperiode(s.getIdsousperiode());
            Double financement = 0d;
            if (!financements.isEmpty()) {
                for (Financementbudget f : financements) {
                    financement += f.getFinancement();
                }
            }

            DevisePeriode dp = null;
            if (devise.getIddevise() != null) {
                dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
            }

            Double pourcentage = (financement / somme) * 100;

            if (dp != null) {
                if (dp.getValeur() != 1D) {
                    financement = financement / dp.getValeur();
                    return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(financement, 2)) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
                }
                return JsfUtil.formaterStringMoney(financement.intValue()) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
            } else {
                if (devise.getCoutUnitaireDefault() != 1D) {
                    financement = financement / devise.getCoutUnitaireDefault();
                    return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(financement, 2)) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
                }
                return JsfUtil.formaterStringMoney(financement.intValue()) + " (" + Utilitaires.arrondiNDecimales(pourcentage, 2) + "%)";
            }
        } catch (Exception e) {
            e.printStackTrace();
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
