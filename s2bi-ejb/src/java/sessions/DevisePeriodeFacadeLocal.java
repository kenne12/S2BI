/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.DevisePeriode;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface DevisePeriodeFacadeLocal {

    void create(DevisePeriode devisePeriode);

    void edit(DevisePeriode devisePeriode);

    void remove(DevisePeriode devisePeriode);

    DevisePeriode find(Object id);

    List<DevisePeriode> findAll();

    List<DevisePeriode> findRange(int[] range);

    int count();

    Integer nextVal();

    List<DevisePeriode> findAllRange();

    List<DevisePeriode> findByIddevise(int iddevise) throws Exception;

    DevisePeriode findByIddevise(int iddevise, int idperiode) throws Exception;

}
