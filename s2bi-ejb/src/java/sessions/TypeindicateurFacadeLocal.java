/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Typeindicateur;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface TypeindicateurFacadeLocal {

    void create(Typeindicateur typeindicateur);

    void edit(Typeindicateur typeindicateur);

    void remove(Typeindicateur typeindicateur);

    Typeindicateur find(Object id);

    List<Typeindicateur> findAll();

    List<Typeindicateur> findRange(int[] range);

    int count();

    Integer nextVal();

    List<Typeindicateur> findAllNom();

}
