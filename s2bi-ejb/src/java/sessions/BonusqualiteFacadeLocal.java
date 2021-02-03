/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Bonusqualite;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface BonusqualiteFacadeLocal {

    void create(Bonusqualite bonusqualite);

    void edit(Bonusqualite bonusqualite);

    void remove(Bonusqualite bonusqualite);

    Bonusqualite find(Object id);

    List<Bonusqualite> findAll();

    List<Bonusqualite> findRange(int[] range);

    int count();
    
}
