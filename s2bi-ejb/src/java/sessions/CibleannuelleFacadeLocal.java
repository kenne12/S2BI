/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cibleannuelle;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface CibleannuelleFacadeLocal {

    void create(Cibleannuelle cibleannuelle);

    void edit(Cibleannuelle cibleannuelle);

    void remove(Cibleannuelle cibleannuelle);

    Cibleannuelle find(Object id);

    List<Cibleannuelle> findAll();

    List<Cibleannuelle> findRange(int[] range);

    int count();
    
}
