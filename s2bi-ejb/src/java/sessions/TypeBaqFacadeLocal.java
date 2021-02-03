/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.TypeBaq;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface TypeBaqFacadeLocal {

    void create(TypeBaq typeBaq);

    void edit(TypeBaq typeBaq);

    void remove(TypeBaq typeBaq);

    TypeBaq find(Object id);

    List<TypeBaq> findAll();

    List<TypeBaq> findRange(int[] range);

    int count();

    List<TypeBaq> findAllRangeCode();

}
