/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Typeuniteorganisation;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface TypeuniteorganisationFacadeLocal {

    void create(Typeuniteorganisation typeuniteorganisation);

    void edit(Typeuniteorganisation typeuniteorganisation);

    void remove(Typeuniteorganisation typeuniteorganisation);

    Typeuniteorganisation find(Object id);

    List<Typeuniteorganisation> findAll();

    List<Typeuniteorganisation> findRange(int[] range);

    int count();

    Integer nextVal();

    List<Typeuniteorganisation> findAllNom();

}
