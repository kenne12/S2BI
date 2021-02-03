/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Couverturepopulation;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface CouverturepopulationFacadeLocal {

    void create(Couverturepopulation couverturepopulation);

    void edit(Couverturepopulation couverturepopulation);

    void remove(Couverturepopulation couverturepopulation);

    Couverturepopulation find(Object id);

    List<Couverturepopulation> findAll();

    List<Couverturepopulation> findRange(int[] range);

    int count();

    Long nextVal();

    List<Couverturepopulation> findByUnite(int uniteOrganisation) throws Exception;

    List<Couverturepopulation> findAllRange() throws Exception;

    List<Couverturepopulation> findByPeriodeCostingUnite(int periodeCosting, int uniteOrganisation) throws Exception;
    
    Couverturepopulation findBySousPeriodeCostingUnite(int sousperiodeCosting, int uniteOrganisation) throws Exception;
    
    List<Couverturepopulation> findBySousPeriodeCostingUniteParent(int sousperiodeCosting, int uniteParent) throws Exception;

}
