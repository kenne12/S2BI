/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.budget_par_habitant;

import entities.Budget;
import entities.Couverturepopulation;
import entities.Devise;
import entities.DevisePeriode;
import entities.Sousperiodecosting;
import entities.Uniteorganisation;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.view.ViewScoped;
import org.primefaces.context.RequestContext;
import utils.JsfUtil;
import utils.Utilitaires;

/**
 *
 * @author kenne
 */
@ManagedBean
@ViewScoped
public class BudgetParHabitantController extends AbstractBudgetParHabitantController implements Serializable {

    /**
     * Creates a new instance of BudgetController
     */
    public BudgetParHabitantController() {
    }

    @PostConstruct
    private void init() {
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

            selectedBudgets.clear();
            uniteorganisations = uniteorganisationFacadeLocal.findParentOrganisation();
            for (Uniteorganisation u : uniteorganisations) {
                Budget b = new Budget();
                b.setIduniteorganisation(u);
                selectedBudgets.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String loadValue(Uniteorganisation u, Sousperiodecosting s) {
        try {
            Double population = 0d;

            List<Budget> budgetTemps = budgetFacadeLocal.findByUniteSousperiode(u.getIduniteorganisation(), s.getIdsousperiode());
            Couverturepopulation cp = cfl.findBySousPeriodeCostingUnite(s.getIdsousperiode(), u.getIduniteorganisation());

            List<Couverturepopulation> cps = cfl.findBySousPeriodeCostingUniteParent(s.getIdsousperiode(), u.getIduniteorganisation());
            for (Couverturepopulation c : cps) {
                population += c.getValeur();
            }

            if (cp != null) {
                if (cp.getValeur() != 0D) {
                    population = cp.getValeur();
                }
            }

            Double resultat = 0d;
            for (Budget b : budgetTemps) {
                resultat += b.getTotal();
            }

            DevisePeriode dp = null;
            if (devise.getIddevise() != null) {
                dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
            }

            List<Uniteorganisation> units = uniteorganisationFacadeLocal.findByOrganisationUnitParent(u.getIduniteorganisation());
            if (units.isEmpty()) {
                if (population != 0D) {
                    if (dp != null) {
                        if (dp.getValeur() != 1d) {
                            return formatStingMoney(Utilitaires.arrondiNDecimales(((resultat / dp.getValeur()) / population), 2));
                        }
                        return formatStingMoney(resultat.intValue() / population.intValue());
                    }
                    if (devise.getCoutUnitaireDefault() != 1) {
                        return formatStingMoney(Utilitaires.arrondiNDecimales(((resultat / devise.getCoutUnitaireDefault())) / population, 2));
                    }
                    return formatStingMoney(resultat.intValue() / population.intValue());
                }
                return "";
            }

            for (Uniteorganisation obj : units) {
                List<Budget> budgs = budgetFacadeLocal.findByUniteSousperiode(obj.getIduniteorganisation(), s.getIdsousperiode());
                for (Budget b : budgs) {
                    resultat += b.getTotal();
                }
            }

            if (resultat != 0d) {
                if (population != 0d) {
                    if (dp != null) {
                        if (dp.getValeur() != 1D) {
                            return formatStingMoney(Utilitaires.arrondiNDecimales(((resultat / dp.getValeur()) / population), 2));
                        }
                        return formatStingMoney(Utilitaires.arrondiNDecimales((resultat / population), 2));
                    }
                    if (devise.getCoutUnitaireDefault() != 1D) {
                        return formatStingMoney(Utilitaires.arrondiNDecimales(((resultat / devise.getCoutUnitaireDefault()) / population), 2));
                    }
                    return formatStingMoney(Utilitaires.arrondiNDecimales((resultat / cp.getValeur()), 2));
                }
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
        return "";
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
            Double resultat = 0d;
            Double resultat2 = 0d;
            DevisePeriode dp = null;
            if (devise.getIddevise() != null) {
                dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
            }

            for (Budget b : selectedBudgets) {

                if (b.getIduniteorganisation().getCostingfosa()) {

                    List<Budget> budgetTemps = budgetFacadeLocal.findByUniteSousperiode(b.getIduniteorganisation().getIduniteorganisation(), s.getIdsousperiode());
                    Couverturepopulation cp = cfl.findBySousPeriodeCostingUnite(s.getIdsousperiode(), b.getIduniteorganisation().getIduniteorganisation());

                    for (Budget b1 : budgetTemps) {
                        resultat += b1.getTotal();
                    }

                    List<Uniteorganisation> units = uniteorganisationFacadeLocal.findByOrganisationUnitParent(b.getIduniteorganisation().getIduniteorganisation());

                    for (Uniteorganisation obj : units) {
                        List<Budget> budgs = budgetFacadeLocal.findByUniteSousperiode(obj.getIduniteorganisation(), s.getIdsousperiode());
                        for (Budget b2 : budgs) {
                            resultat += b2.getTotal();
                        }
                    }
                    if (cp != null) {
                        resultat2 += Utilitaires.arrondiNDecimales(((resultat / dp.getValeur()) / cp.getValeur()), 2);
                    }
                }
            }

            if (resultat2 != 0d) {
                return formatStingMoney(Utilitaires.arrondiNDecimales((resultat / selectedBudgets.size()), 2));
            }
            return "";
        } catch (Exception e) {
            result = "";
        }
        return result;
    }

    public void updateData() {
        try {
            sousperiodecostings.clear();
            if (periodecosting.getIdperiodecosting() != 0) {
                sousperiodecostings.clear();
                sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(periodecosting.getIdperiodecosting(), false);
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
