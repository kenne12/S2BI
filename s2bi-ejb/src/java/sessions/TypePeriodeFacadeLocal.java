/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.TypePeriode;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface TypePeriodeFacadeLocal {

    void create(TypePeriode typePeriode);

    void edit(TypePeriode typePeriode);

    void remove(TypePeriode typePeriode);

    TypePeriode find(Object id);

    List<TypePeriode> findAll();

    List<TypePeriode> findRange(int[] range);

    int count();
    
}
