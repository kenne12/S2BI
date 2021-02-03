/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Financementbudget;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface FinancementbudgetFacadeLocal {

    void create(Financementbudget financementbudget);

    void edit(Financementbudget financementbudget);

    void remove(Financementbudget financementbudget);

    Financementbudget find(Object id);

    List<Financementbudget> findAll();

    List<Financementbudget> findRange(int[] range);

    int count();

    Long nextVal();

    Financementbudget findByBailleurTypeUoSousperiode(int idbailleur, int idTypeUo, int idSousPeriode) throws Exception;

    List<Financementbudget> findByTypeUoPeriodecostingIdBailleur(int idTypeUo, int idPeriode, int idBailleur) throws Exception;

    List<Financementbudget> findByBailleurSousperiode(int idbailleur, int idSousPeriode) throws Exception;

    List<Financementbudget> findByBailleurPeriode(int idbailleur, int idPeriode) throws Exception;

    List<Financementbudget> findBySousperiode(int idSousPeriode) throws Exception;

    List<Financementbudget> findByPeriode(int idperiode) throws Exception;

    List<Financementbudget> findByTypeUoIdsousperiode(int idTypeUo, int idSousPeriode) throws Exception;
    
    List<Financementbudget> findByTypeUoIdperiode(int idTypeUo, int idPeriode) throws Exception;

}
