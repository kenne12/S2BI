/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Indicateurpivot;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface IndicateurpivotFacadeLocal {

    void create(Indicateurpivot indicateurpivot);

    void edit(Indicateurpivot indicateurpivot);

    void remove(Indicateurpivot indicateurpivot);

    Indicateurpivot find(Object id);

    List<Indicateurpivot> findAll();

    List<Indicateurpivot> findRange(int[] range);

    int count();
    
}
