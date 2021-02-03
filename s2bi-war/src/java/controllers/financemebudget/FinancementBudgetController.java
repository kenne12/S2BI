/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.financemebudget;

import entities.Budget;
import entities.Devise;
import entities.DevisePeriode;
import entities.Financement;
import entities.Financementbudget;
import entities.Sousperiodecosting;
import entities.Typeuniteorganisation;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import org.primefaces.context.RequestContext;
import utils.JsfUtil;
import utils.SessionMBean;
import utils.Utilitaires;

/**
 *
 * @author kenne
 */
@ManagedBean
@SessionScoped
public class FinancementBudgetController extends AbstractFinancementBudgetController implements Serializable {

    /**
     * Creates a new instance of BudgetController
     */
    public FinancementBudgetController() {
    }

    @PostConstruct
    private void init() {
        try {
            sousperiodecostings.clear();
            bailleurfond.setIdbailleurfond(0);
            try {
                devises = deviseFacadeLocal.findAllNom();
                for (Devise d : devises) {
                    if (d.getDefaultM()) {
                        devise = d;
                        break;
                    }
                }

                if (SessionMBean.getPeriodeCosting() != null) {
                    sousperiodecostings = sousperiodecostingFacadeLocal.findByPeriodeCostingBase(SessionMBean.getPeriodeCosting().getIdperiodecosting(), false);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            selectedfinancementbudgets.clear();
            List<Typeuniteorganisation> typeuniteorganisations = typeuniteorganisationFacadeLocal.findAllNom();
            for (Typeuniteorganisation t : typeuniteorganisations) {
                Financementbudget fb = new Financementbudget();
                fb.setIdfinancementbudget(0L);
                fb.setIdtypeUo(t);
                selectedfinancementbudgets.add(fb);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(10L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";

            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (!Utilitaires.isAccess(11L)) {
                signalError("acces_refuse");
                return;
            }

            if (financementbudget == null) {
                signalError("not_selected_row");
                return;
            }

            mode = "Edit";

            RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void generatePlan() {
        try {
            if (periodecosting.getIdperiodecosting() != 0) {

                if (!Utilitaires.isAccess(44L)) {
                    signalError("acces_refuse");
                    return;
                }

                for (Sousperiodecosting spc : sousperiodecostings) {
                    List<Financement> financementTemps = financementFacadeLocal.findBySousPeriode(spc.getIdsousperiode());
                    for (Financement f : financementTemps) {

                        List<Budget> budgetsTemp = budgetFacadeLocal.findByTypeUoSousperiode(f.getIdtypeuniteorganisation().getIdtypeuniteorganisation(), spc.getIdsousperiode());
                        Double somme = 0d;
                        for (Budget b : budgetsTemp) {
                            somme += b.getTotal();
                        }

                        Financementbudget fbTemp = financementbudgetFacadeLocal.findByBailleurTypeUoSousperiode(f.getIdbailleurfond().getIdbailleurfond(), f.getIdtypeuniteorganisation().getIdtypeuniteorganisation(), spc.getIdsousperiode());
                        if (fbTemp == null) {
                            Financementbudget fb = new Financementbudget();
                            fb.setIdfinancementbudget(financementbudgetFacadeLocal.nextVal());
                            fb.setBudget(somme);
                            fb.setFinancement((somme * f.getPourcentage()) / 100);
                            fb.setIdsousPeriode(spc);
                            fb.setIdperiode(spc.getIdperiode().getIdperiode());
                            fb.setIdtypeUo(f.getIdtypeuniteorganisation());
                            fb.setIdbailleurfond(f.getIdbailleurfond());
                            fb.setPourcentage(f.getPourcentage());

                            financementbudgetFacadeLocal.create(fb);
                        } else {
                            fbTemp.setBudget(somme);
                            fbTemp.setPourcentage(f.getPourcentage());
                            fbTemp.setFinancement((somme * f.getPourcentage()) / 100);
                            financementbudgetFacadeLocal.edit(fbTemp);
                        }
                    }
                }
                signalSuccess();
                RequestContext.getCurrentInstance().execute("PF('AjaxNotifyDialog').hide()");
                return;
            }
            signalError("verifier_formulaire");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public String loadValue(Typeuniteorganisation t, Sousperiodecosting s) {
        try {
            if (periodecosting.getIdperiodecosting() != 0 && periodecosting.getIdperiodecosting() != null) {
                if (bailleurfond.getIdbailleurfond() != 0 && bailleurfond.getIdbailleurfond() != null) {

                    Financementbudget f = financementbudgetFacadeLocal.findByBailleurTypeUoSousperiode(bailleurfond.getIdbailleurfond(), t.getIdtypeuniteorganisation(), s.getIdsousperiode());

                    if (f != null) {

                        DevisePeriode dp = null;
                        if (devise.getIddevise() != null) {
                            dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
                        }

                        if (dp != null) {
                            if (dp.getValeur() != 1D) {
                                return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(f.getFinancement() / dp.getValeur(), 2));
                            }
                            return JsfUtil.formaterStringMoney(f.getFinancement().intValue());
                        } else {
                            if (devise.getCoutUnitaireDefault() != 1D) {
                                return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(f.getFinancement() / devise.getCoutUnitaireDefault(), 2));
                            }
                            return JsfUtil.formaterStringMoney(f.getFinancement().intValue());
                        }
                    }
                    return null;
                } else {
                    List<Financementbudget> financementBTemps = financementbudgetFacadeLocal.findByTypeUoIdsousperiode(t.getIdtypeuniteorganisation(), s.getIdsousperiode());

                    if (!financementBTemps.isEmpty()) {

                        DevisePeriode dp = null;
                        if (devise.getIddevise() != null) {
                            dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
                        }

                        Double somme = 0d;
                        for (Financementbudget fb : financementBTemps) {
                            somme += fb.getFinancement();
                        }
                        if (dp != null) {
                            if (dp.getValeur() != 1D) {
                                return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / dp.getValeur(), 2));
                            }
                            return JsfUtil.formaterStringMoney(somme.intValue());
                        } else {
                            if (devise.getCoutUnitaireDefault() != 1D) {
                                return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / devise.getCoutUnitaireDefault(), 2));
                            }
                            return JsfUtil.formaterStringMoney(somme.intValue());
                        }
                    }
                    return null;
                }
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String sommeBudget(Sousperiodecosting s) {

        try {
            if (bailleurfond.getIdbailleurfond() != 0 && bailleurfond.getIdbailleurfond() != null) {
                List<Financementbudget> fbTemps = financementbudgetFacadeLocal.findByBailleurSousperiode(bailleurfond.getIdbailleurfond(), s.getIdsousperiode());
                if (!fbTemps.isEmpty()) {
                    Double somme = 0d;
                    for (Financementbudget fb : fbTemps) {
                        somme += fb.getFinancement();
                    }

                    DevisePeriode dp = null;
                    if (devise.getIddevise() != null) {
                        dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
                    }

                    if (dp != null) {
                        if (dp.getValeur() != 1D) {
                            return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / dp.getValeur(), 2));
                        }
                        return JsfUtil.formaterStringMoney(somme.intValue());
                    } else {
                        if (devise.getCoutUnitaireDefault() != 1D) {
                            return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / devise.getCoutUnitaireDefault(), 2));
                        }
                        return JsfUtil.formaterStringMoney(somme.intValue());
                    }
                }
                return null;
            } else {
                List<Financementbudget> financementBTemps = financementbudgetFacadeLocal.findBySousperiode(s.getIdsousperiode());
                if (!financementBTemps.isEmpty()) {

                    DevisePeriode dp = null;
                    if (devise.getIddevise() != null) {
                        dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
                    }

                    Double somme = 0d;
                    for (Financementbudget fb : financementBTemps) {
                        somme += fb.getFinancement();
                    }
                    if (dp != null) {
                        if (dp.getValeur() != 1D) {
                            return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / dp.getValeur(), 2));
                        }
                        return JsfUtil.formaterStringMoney(somme.intValue());
                    } else {
                        if (devise.getCoutUnitaireDefault() != 1D) {
                            return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / devise.getCoutUnitaireDefault(), 2));
                        }
                        return JsfUtil.formaterStringMoney(somme.intValue());
                    }
                }
                return null;
            }
        } catch (Exception e) {
            return null;
        }
    }

    public String resteBuget(Typeuniteorganisation t) {
        try {
            if (bailleurfond.getIdbailleurfond() != 0) {
                Double somme = 0d;
                List<Financementbudget> fbTemps = financementbudgetFacadeLocal.findByTypeUoPeriodecostingIdBailleur(t.getIdtypeuniteorganisation(), periodecosting.getIdperiodecosting(), bailleurfond.getIdbailleurfond());
                if (!fbTemps.isEmpty()) {

                    for (Financementbudget fb : fbTemps) {
                        somme += fb.getFinancement();
                    }

                    if (devise.getCoutUnitaireDefault() != 1D) {
                        return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / devise.getCoutUnitaireDefault(), 2));
                    }
                    return JsfUtil.formaterStringMoney(somme.intValue());
                }
                return null;
            } else {
                List<Financementbudget> financementBTemps = financementbudgetFacadeLocal.findByTypeUoIdperiode(t.getIdtypeuniteorganisation(), periodecosting.getIdperiodecosting());
                if (!financementBTemps.isEmpty()) {

                    Double somme = 0d;
                    for (Financementbudget fb : financementBTemps) {
                        somme += fb.getFinancement();
                    }

                    if (devise.getCoutUnitaireDefault() != 1D) {
                        return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / devise.getCoutUnitaireDefault(), 2));
                    }
                    return JsfUtil.formaterStringMoney(somme.intValue());
                }
                return null;
            }
        } catch (Exception e) {
            return null;
        }
    }

    public String totauxBuget() {
        try {
            if (bailleurfond.getIdbailleurfond() != 0) {
                if (periodecosting.getIdperiodecosting() != 0) {
                    Double somme = 0D;
                    List<Financementbudget> fbTemps = financementbudgetFacadeLocal.findByBailleurPeriode(bailleurfond.getIdbailleurfond(), periodecosting.getIdperiodecosting());
                    if (!fbTemps.isEmpty()) {
                        for (Financementbudget fb : fbTemps) {
                            somme += fb.getFinancement().intValue();
                        }

                        if (devise.getCoutUnitaireDefault() != 1D) {
                            return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / devise.getCoutUnitaireDefault(), 2));
                        }
                        return JsfUtil.formaterStringMoney(somme.intValue());
                    }
                    return null;
                }
                return null;
            } else {
                List<Financementbudget> financementBTemps = financementbudgetFacadeLocal.findByPeriode(periodecosting.getIdperiodecosting());
                if (!financementBTemps.isEmpty()) {

                    Double somme = 0d;
                    for (Financementbudget fb : financementBTemps) {
                        somme += fb.getFinancement();
                    }

                    if (devise.getCoutUnitaireDefault() != 1D) {
                        return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales(somme / devise.getCoutUnitaireDefault(), 2));
                    }
                    return JsfUtil.formaterStringMoney(somme.intValue());
                }
                return null;
            }
        } catch (Exception e) {
            return null;
        }
    }

    public void updateData() {
        try {
            sousperiodecostings.clear();
            if (periodecosting.getIdperiodecosting() != 0) {
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

    public void create() {
        
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
