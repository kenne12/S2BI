/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Typescore;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface TypescoreFacadeLocal {

    void create(Typescore typescore);

    void edit(Typescore typescore);

    void remove(Typescore typescore);

    Typescore find(Object id);

    List<Typescore> findAll();

    List<Typescore> findRange(int[] range);

    int count();
    
}
