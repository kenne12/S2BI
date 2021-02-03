/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Ciblerealisation;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface CiblerealisationFacadeLocal {

    void create(Ciblerealisation ciblerealisation);

    void edit(Ciblerealisation ciblerealisation);

    void remove(Ciblerealisation ciblerealisation);

    Ciblerealisation find(Object id);

    List<Ciblerealisation> findAll();

    List<Ciblerealisation> findRange(int[] range);

    int count();

    Long nextVal();

    List<Ciblerealisation> findAllBase() throws Exception;

    List<Ciblerealisation> findAllBase(boolean costingfosa) throws Exception;

    List<Ciblerealisation> findByUniteSousPeriode(int idunite, int sousperiode) throws Exception;

    List<Ciblerealisation> findByUnitePeriodeIndicateur(int idunite, int sousperiode, int indicateur) throws Exception;

    List<Ciblerealisation> findByUnitePeriodePeriode(int idunite, int idperiode, int idindicateur) throws Exception;

}
