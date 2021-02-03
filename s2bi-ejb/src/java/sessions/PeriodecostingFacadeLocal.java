/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Periodecosting;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface PeriodecostingFacadeLocal {

    void create(Periodecosting periodecosting);

    void edit(Periodecosting periodecosting);

    void remove(Periodecosting periodecosting);

    Periodecosting find(Object id);

    List<Periodecosting> findAll();

    List<Periodecosting> findRange(int[] range);

    int count();

    Integer nextVal();

    List<Periodecosting> findAllNom();

}
