/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Niveaupyramide;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface NiveaupyramideFacadeLocal {

    void create(Niveaupyramide niveaupyramide);

    void edit(Niveaupyramide niveaupyramide);

    void remove(Niveaupyramide niveaupyramide);

    Niveaupyramide find(Object id);

    List<Niveaupyramide> findAll();

    List<Niveaupyramide> findRange(int[] range);

    int count();

    Integer nextVal();

    List<Niveaupyramide> findAllNumero();

}
