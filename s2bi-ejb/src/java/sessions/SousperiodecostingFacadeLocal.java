/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Sousperiodecosting;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface SousperiodecostingFacadeLocal {

    void create(Sousperiodecosting sousperiodecosting);

    void edit(Sousperiodecosting sousperiodecosting);

    void remove(Sousperiodecosting sousperiodecosting);

    Sousperiodecosting find(Object id);

    List<Sousperiodecosting> findAll();

    List<Sousperiodecosting> findRange(int[] range);

    int count();

    Integer nextVal();

    List<Sousperiodecosting> findAllNom();

    List<Sousperiodecosting> findByPeriodeCosting(int idPeriodeCosting) throws Exception;
    
    List<Sousperiodecosting> findByPeriodeCostingBase(int idPeriodeCosting , boolean periode_debut) throws Exception;

}
