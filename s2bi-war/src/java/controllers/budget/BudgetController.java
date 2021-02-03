/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.budget;

import entities.Budget;
import entities.Ciblerealisation;
import entities.Couverturepopulation;
import entities.Devise;
import entities.DevisePeriode;
import entities.Indicateur;
import entities.Sousperiodecosting;
import entities.Uniteorganisation;
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
public class BudgetController extends AbstractBudgetController implements Serializable {

    /**
     * Creates a new instance of BudgetController
     */
    public BudgetController() {
    }

    @PostConstruct
    private void init() {
        couverturepopulation = new Couverturepopulation();
        uniteorganisation = new Uniteorganisation();
        uniteorganisation.setIduniteorganisation(0);
        try {
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

    public void prepareCreate() {
        try {
            if (!Utilitaires.isAccess(43L)) {
                signalError("acces_refuse");
                return;
            }

            mode = "Create";
            enabledSelect = false;

            couverturepopulations.clear();

            selectedBudgets.clear();
            sousperiodecostings.clear();

            couverturepopulation = new Couverturepopulation();
            sousperiodecosting = new Sousperiodecosting();
            uniteorganisation = new Uniteorganisation();
            periodecosting = SessionMBean.getPeriodeCosting();
            uniteorganisation.setIduniteorganisation(0);

            renderedCible = true;

            RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').show()");
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void prepareEdit() {
        try {
            if (budget != null) {

                if (!Utilitaires.isAccess(43L)) {
                    signalError("acces_refuse");
                    return;
                }

                mode = "Edit";
                enabledSelect = true;

                RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').show()");
            } else {
                signalError("not_selected_row");
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void updateRenderedColumn() {
        renderedCible = true;
    }

    public void generate() {
        try {
            ut.begin();

            if (uniteorganisation.getIduniteorganisation() == 0) {
                signalError("verifier_formulaire");
                return;
            }

            if (ciblerealisations.isEmpty()) {
                signalError("costing_base_non_fait");
                return;
            }

            for (Budget ligne : selectedBudgets) {

                for (Sousperiodecosting spc : sousperiodecostings) {

                    List<Budget> bTemps = budgetFacadeLocal.findByUniteIndicateurSousperiode(uniteorganisation.getIduniteorganisation(), ligne.getIdindicateur().getIdindicateur(), spc.getIdsousperiode());
                    if (bTemps.isEmpty()) {

                        Budget b = new Budget();
                        b.setIdsousPeriode(spc);
                        b.setIdindicateur(ligne.getIdindicateur());
                        b.setIduniteorganisation(uniteorganisation);

                        List<Ciblerealisation> cTemp = ciblerealisationFacadeLocal.findByUnitePeriodeIndicateur(uniteorganisation.getIduniteorganisation(), spc.getIdsousperiode(), ligne.getIdindicateur().getIdindicateur());
                        double cible = 0d;
                        double cu = 0d;
                        double couverture = 0d;
                        if (!cTemp.isEmpty()) {
                            cible = cTemp.get(0).getValeurcible();
                            cu = cTemp.get(0).getCoutUnitaire();
                            couverture = cTemp.get(0).getCouverture();
                        }

                        Couverturepopulation cpTemps = couverturepopulationFacadeLocal.findBySousPeriodeCostingUnite(spc.getIdsousperiode(), uniteorganisation.getIduniteorganisation());

                        double scoreEquite = 0;
                        double scoreQualite = 0d;
                        double majoration = 0d;
                        double baq = 0;
                        if (cpTemps != null) {
                            scoreEquite = cpTemps.getValScoreEquite();
                            majoration = cpTemps.getMajoration();
                            baq = cpTemps.getBaq();
                            scoreQualite = cpTemps.getValScoreQualite();
                        }

                        Double total1 = cible * cu * (couverture / 100);
                        Double bonusEquite = total1 * (scoreEquite / 100);
                        Double total2 = total1 + bonusEquite;
                        Double bonusQualite = total2 * (scoreQualite / 100) * (majoration / 100);

                        Double total = total2 + bonusQualite + baq;

                        b.setBonusequite(bonusEquite);
                        b.setBonusqualite(bonusQualite);
                        b.setTotal1(total1);
                        b.setTotal2(total2);
                        b.setTotal(total);
                        b.setBaq(baq);
                        b.setIdbudget(budgetFacadeLocal.nextVal());
                        budgetFacadeLocal.create(b);

                        if (!cTemp.isEmpty()) {
                            Ciblerealisation cr = cTemp.get(0);
                            cr.setBonusEquite(bonusEquite);
                            cr.setBonusQualite(bonusQualite);
                            cr.setTotal1(total1);
                            cr.setTotal2(total2);
                            cr.setBudget(total);
                            ciblerealisationFacadeLocal.edit(cr);
                        }

                    } else {

                        Budget b = bTemps.get(0);
                        b.setIdsousPeriode(spc);
                        b.setIdindicateur(ligne.getIdindicateur());
                        b.setIduniteorganisation(uniteorganisation);

                        List<Ciblerealisation> cTemp = ciblerealisationFacadeLocal.findByUnitePeriodeIndicateur(uniteorganisation.getIduniteorganisation(), spc.getIdsousperiode(), ligne.getIdindicateur().getIdindicateur());
                        double cible = 0d;
                        double cu = 0d;
                        double couverture = 0d;
                        if (!cTemp.isEmpty()) {
                            cible = cTemp.get(0).getValeurcible();
                            cu = cTemp.get(0).getCoutUnitaire();
                            couverture = cTemp.get(0).getCouverture();
                        }

                        Couverturepopulation cpTemps = couverturepopulationFacadeLocal.findBySousPeriodeCostingUnite(spc.getIdsousperiode(), uniteorganisation.getIduniteorganisation());

                        double scoreEquite = 0;
                        double scoreQualite = 0d;
                        double majoration = 0d;
                        double baq = 0;
                        if (cpTemps != null) {
                            scoreEquite = cpTemps.getValScoreEquite();
                            majoration = cpTemps.getMajoration();
                            baq = cpTemps.getBaq();
                            scoreQualite = cpTemps.getValScoreQualite();
                        }

                        Double total1 = cible * cu * (couverture / 100);
                        Double bonusEquite = total1 * (scoreEquite / 100);
                        Double total2 = total1 + bonusEquite;
                        Double bonusQualite = total2 * (scoreQualite / 100) * (majoration / 100);

                        Double total = total2 + bonusQualite + baq;

                        b.setBonusequite(bonusEquite);
                        b.setBonusqualite(bonusQualite);
                        b.setTotal1(total1);
                        b.setTotal2(total2);
                        b.setTotal(total);
                        b.setBaq(baq);

                        budgetFacadeLocal.edit(b);

                        if (!cTemp.isEmpty()) {
                            Ciblerealisation cr = cTemp.get(0);
                            cr.setBonusEquite(bonusEquite);
                            cr.setBonusQualite(bonusQualite);
                            cr.setTotal1(total1);
                            cr.setTotal2(total2);
                            cr.setBudget(total);
                            ciblerealisationFacadeLocal.edit(cr);
                        }
                    }
                }
            }
            ut.commit();

            signalSuccess();
        } catch (Exception e) {
            e.printStackTrace();
            signalException(e);
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

    public String loadValue(Indicateur indicateur, Sousperiodecosting s) {
        try {
            if (uniteorganisation.getIduniteorganisation() != 0) {

                DevisePeriode dp = null;
                if (devise.getIddevise() != null) {
                    dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
                }

                List<Budget> budgetTemps = budgetFacadeLocal.findByUniteIndicateurSousperiode(uniteorganisation.getIduniteorganisation(), indicateur.getIdindicateur(), s.getIdsousperiode());
                if (!budgetTemps.isEmpty()) {
                    if (dp != null) {
                        if (dp.getValeur() != 1) {
                            return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales((budgetTemps.get(0).getTotal() / dp.getValeur()), 2));
                        }
                        return JsfUtil.formaterStringMoney(budgetTemps.get(0).getTotal().intValue());
                    }
                    if (devise.getCoutUnitaireDefault() != 1) {
                        return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales((budgetTemps.get(0).getTotal() / devise.getCoutUnitaireDefault()), 2));
                    }
                    return JsfUtil.formaterStringMoney(budgetTemps.get(0).getTotal().intValue());
                }
            }
            return "";
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }

    }

    public String loadValue(Indicateur indicateur) {
        try {
            if (uniteorganisation.getIduniteorganisation() != 0) {
                if (periodecosting.getIdperiodecosting() != 0) {
                    List<Budget> budgetTemps = budgetFacadeLocal.findByUniteIndicateurPeriode(uniteorganisation.getIduniteorganisation(), indicateur.getIdindicateur(), periodecosting.getIdperiodecosting());
                    if (!budgetTemps.isEmpty()) {
                        Double somme = 0d;
                        for (Budget b : budgetTemps) {
                            somme += b.getTotal();
                        }

                        if (devise.getCoutUnitaireDefault() != 1) {
                            return formatStingMoney(Utilitaires.arrondiNDecimales((somme / devise.getCoutUnitaireDefault()), 2));
                        }
                        return formatStingMoney(somme.intValue());
                    }
                    return null;
                }
                return null;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String loadValue() {
        try {
            if (uniteorganisation.getIduniteorganisation() != 0) {
                if (periodecosting.getIdperiodecosting() != 0) {
                    List<Budget> budgetTemps = budgetFacadeLocal.findByUnitePeriodecosting(uniteorganisation.getIduniteorganisation(), periodecosting.getIdperiodecosting());
                    if (!budgetTemps.isEmpty()) {
                        Double somme = 0d;
                        for (Budget b : budgetTemps) {
                            somme += b.getTotal();
                        }

                        if (devise.getCoutUnitaireDefault() != 1) {
                            return formatStingMoney(Utilitaires.arrondiNDecimales((somme / devise.getCoutUnitaireDefault()), 2));
                        }
                        return formatStingMoney(somme.intValue());
                    }
                    return null;
                }
                return null;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String sommeBudget(Sousperiodecosting s) {
        String result = "";
        Double somme = 0d;
        try {
            if (uniteorganisation.getIduniteorganisation() != 0) {

                DevisePeriode dp = null;
                if (devise.getIddevise() != null) {
                    dp = devisePeriodeFacadeLocal.findByIddevise(devise.getIddevise(), s.getIdperiode().getIdperiode());
                }

                List<Budget> budgetTemps = budgetFacadeLocal.findByUniteSousPeriodecosting(uniteorganisation.getIduniteorganisation(), s.getIdsousperiode());
                if (!budgetTemps.isEmpty()) {
                    for (Budget b : budgetTemps) {
                        somme += b.getTotal();
                    }
                    if (dp != null) {
                        if (dp.getValeur() != 1) {
                            return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales((somme / dp.getValeur()), 2));
                        }
                        return JsfUtil.formaterStringMoney(somme.intValue());
                    }
                    if (devise.getCoutUnitaireDefault() != 1) {
                        return JsfUtil.formaterStringMoney(Utilitaires.arrondiNDecimales((somme / devise.getCoutUnitaireDefault()), 2));
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
            sousperiodecostings.clear();
            if (periodecosting.getIdperiodecosting() != 0) {
                if (uniteorganisation.getIduniteorganisation() != 0) {

                    couverturepopulations = couverturepopulationFacadeLocal.findByPeriodeCostingUnite(periodecosting.getIdperiodecosting(), uniteorganisation.getIduniteorganisation());

                    sousperiodecostings.clear();
                    List<Sousperiodecosting> spcs = sousperiodecostingFacadeLocal.findByPeriodeCosting(periodecosting.getIdperiodecosting());
                    for (Sousperiodecosting s : spcs) {
                        if (s.getPeriodedebut()) {
                            sousperiodecosting = s;
                        } else {
                            sousperiodecostings.add(s);
                        }
                    }

                    ciblerealisations = ciblerealisationFacadeLocal.findByUniteSousPeriode(uniteorganisation.getIduniteorganisation(), sousperiodecosting.getIdsousperiode());

                    List<Budget> budgetTemps = budgetFacadeLocal.findByUniteSousPeriodecosting(uniteorganisation.getIduniteorganisation(), sousperiodecostings.get(0).getIdsousperiode());
                    selectedBudgets.clear();
                    if (!ciblerealisations.isEmpty()) {

                        for (Couverturepopulation cps : couverturepopulations) {
                            if (cps.getIdsousperiode().getPeriodedebut()) {
                                couverturepopulation = cps;
                                break;
                            }
                        }

                        if (!budgetTemps.isEmpty()) {
                            selectedBudgets = budgetTemps;
                        } else {
                            for (Ciblerealisation cr : ciblerealisations) {
                                Budget b = new Budget();
                                b.setIdindicateur(cr.getIdindicateur());
                                b.setIdbudget(0L);
                                b.setBonusqualite(0D);
                                b.setTotal(0D);
                                selectedBudgets.add(b);
                            }
                        }
                    } else {
                        signalError("costing_base_non_fait");
                        return;
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

    public void updateCalcul(int index) {
        try {
            Ciblerealisation cr = selectedCrs.get(index);
            double valeur = (cr.getValeurrealisee() / cr.getValeurcible()) * 100;
            selectedCrs.get(index).setCouverture(Math.rint(valeur));
        } catch (Exception e) {
            selectedCrs.get(index).setCouverture(0d);
        }
    }

    public void create() {
        try {
            if (mode.equals("Create")) {

                RequestContext.getCurrentInstance().execute("PF('UtilisateurCreerDialog').hide()");
                signalSuccess();
            } else {
                ut.begin();

                RequestContext.getCurrentInstance().execute("PF('SelectPeriodDialog').hide()");
                signalSuccess();
            }
        } catch (Exception e) {
            signalException(e);
        }
    }

    public void delete() {
        try {
            if (couverturepopulation != null) {

                if (!Utilitaires.isAccess(12L)) {
                    signalError("acces_refuse");
                    return;
                }

                ut.begin();
                couverturepopulationFacadeLocal.remove(couverturepopulation);
                ut.commit();
                Utilitaires.saveOperation(mouchardFacadeLocal, "Suppresion de la periode de costing : " + periodecosting.getLibelle(), SessionMBean.getUserAccount());
                signalSuccess();
            } else {
                signalError("not_row_selected");
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
