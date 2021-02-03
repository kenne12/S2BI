/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Uniteorganisation;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface UniteorganisationFacadeLocal {

    void create(Uniteorganisation uniteorganisation);

    void edit(Uniteorganisation uniteorganisation);

    void remove(Uniteorganisation uniteorganisation);

    Uniteorganisation find(Object id);

    List<Uniteorganisation> findAll();

    List<Uniteorganisation> findRange(int[] range);

    int count();

    Integer nextVal();

    List<Uniteorganisation> findParentOrganisation() throws Exception;

    List<Uniteorganisation> findAllRange() throws Exception;

    List<Uniteorganisation> findAllRange(boolean costingfosa) throws Exception;

    List<Uniteorganisation> findByOrganisationUnitParent(int idparent) throws Exception;
    
    List<Uniteorganisation> findByTypeUo(int idTyoeUo) throws Exception;

}
