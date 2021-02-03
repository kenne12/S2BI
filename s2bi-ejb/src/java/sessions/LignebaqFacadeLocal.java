/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Lignebaq;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface LignebaqFacadeLocal {

    void create(Lignebaq lignebaq);

    void edit(Lignebaq lignebaq);

    void remove(Lignebaq lignebaq);

    Lignebaq find(Object id);

    List<Lignebaq> findAll();

    List<Lignebaq> findRange(int[] range);

    int count();

    Long nextVal();

    List<Lignebaq> findByPerioCostingUnite(int idperiode, int idunite) throws Exception;

    List<Lignebaq> findByPerioCostingUniteBase(int idperiode, int idunite) throws Exception;

    List<Lignebaq> findByCouvertureRubrique(Long idcouverture, int idtypebaq) throws Exception;

    List<Lignebaq> findByCouverture(Long idcouverture) throws Exception;

}
