/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Financement;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface FinancementFacadeLocal {

    void create(Financement financement);

    void edit(Financement financement);

    void remove(Financement financement);

    Financement find(Object id);

    List<Financement> findAll();

    List<Financement> findRange(int[] range);

    int count();

    Long nextVal();

    List<Financement> findAllRange();

    List<Financement> findBySousPeriodeTypeUo(int idsousperiode, int idtypeUo) throws Exception;

    List<Financement> findBySousPeriode(int idsousperiode) throws Exception;

}
