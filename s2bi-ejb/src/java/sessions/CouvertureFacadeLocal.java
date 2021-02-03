/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Couverture;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface CouvertureFacadeLocal {

    void create(Couverture couverture);

    void edit(Couverture couverture);

    void remove(Couverture couverture);

    Couverture find(Object id);

    List<Couverture> findAll();

    List<Couverture> findRange(int[] range);

    int count();
    
}
