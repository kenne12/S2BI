/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Budget;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface BudgetFacadeLocal {

    void create(Budget budget);

    void edit(Budget budget);

    void remove(Budget budget);

    Budget find(Object id);

    List<Budget> findAll();

    List<Budget> findRange(int[] range);

    int count();

    Long nextVal();

    List<Budget> findByUnitePeriodecosting(int idunite, int idperiodecosting) throws Exception;

    List<Budget> findByUniteSousPeriodecosting(int idunite, int idsousperiode) throws Exception;

    List<Budget> findByUniteIndicateurSousperiode(int idunite, int idindicateur, int idsousperiode) throws Exception;
    
    List<Budget> findByUniteIndicateurPeriode(int idunite, int idindicateur, int idperiode) throws Exception;

    List<Budget> findByUniteSousperiode(int idunite, int idsousperiode) throws Exception;

    List<Budget> findByTypeUoSousperiode(int idTypeUo, int idsousperiode) throws Exception;

    List<Budget> findByTypeUoPeriodecosting(int idTypeUo, int idperiodecosting) throws Exception;

    List<Budget> findByPeriodecosting(int idperiodecosting) throws Exception;

    List<Budget> findBySousperiode(int idsousperiode) throws Exception;

}
