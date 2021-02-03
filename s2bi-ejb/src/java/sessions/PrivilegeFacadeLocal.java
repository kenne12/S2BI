/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Privilege;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface PrivilegeFacadeLocal {

    void create(Privilege privilege);

    void edit(Privilege privilege);

    void remove(Privilege privilege);

    Privilege find(Object id);

    List<Privilege> findAll();

    List<Privilege> findRange(int[] range);

    int count();

    List<Privilege> findAll1();

    Integer nextVal();

    List<Privilege> findByUser(Long utilisateur);

    Privilege findByUser(Long utilisateur, int menu);

    void delete(int menu, Long utilisateur);

}
