/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Groupindicateur;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface GroupindicateurFacadeLocal {

    void create(Groupindicateur groupindicateur);

    void edit(Groupindicateur groupindicateur);

    void remove(Groupindicateur groupindicateur);

    Groupindicateur find(Object id);

    List<Groupindicateur> findAll();

    List<Groupindicateur> findRange(int[] range);

    int count();

    Integer nextVal();

    List<Groupindicateur> findAllNom();
    
}
