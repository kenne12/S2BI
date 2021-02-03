/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Valeurscore;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface ValeurscoreFacadeLocal {

    void create(Valeurscore valeurscore);

    void edit(Valeurscore valeurscore);

    void remove(Valeurscore valeurscore);

    Valeurscore find(Object id);

    List<Valeurscore> findAll();

    List<Valeurscore> findRange(int[] range);

    int count();
    
}
