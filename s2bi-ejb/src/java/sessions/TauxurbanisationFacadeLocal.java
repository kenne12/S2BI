/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Tauxurbanisation;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface TauxurbanisationFacadeLocal {

    void create(Tauxurbanisation tauxurbanisation);

    void edit(Tauxurbanisation tauxurbanisation);

    void remove(Tauxurbanisation tauxurbanisation);

    Tauxurbanisation find(Object id);

    List<Tauxurbanisation> findAll();

    List<Tauxurbanisation> findRange(int[] range);

    int count();
    
}
