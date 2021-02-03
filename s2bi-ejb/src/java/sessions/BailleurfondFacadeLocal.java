/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Bailleurfond;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface BailleurfondFacadeLocal {

    void create(Bailleurfond bailleurfond);

    void edit(Bailleurfond bailleurfond);

    void remove(Bailleurfond bailleurfond);

    Bailleurfond find(Object id);

    List<Bailleurfond> findAll();

    List<Bailleurfond> findRange(int[] range);

    int count();

    Integer nextVal();

    List<Bailleurfond> findAllNom();

}
