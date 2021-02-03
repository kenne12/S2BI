/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Coutunitaireindicateur;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface CoutunitaireindicateurFacadeLocal {

    void create(Coutunitaireindicateur coutunitaireindicateur);

    void edit(Coutunitaireindicateur coutunitaireindicateur);

    void remove(Coutunitaireindicateur coutunitaireindicateur);

    Coutunitaireindicateur find(Object id);

    List<Coutunitaireindicateur> findAll();

    List<Coutunitaireindicateur> findRange(int[] range);

    int count();
    
}
