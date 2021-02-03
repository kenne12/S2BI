/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.TypestructureIndicateur;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface TypestructureIndicateurFacadeLocal {

    void create(TypestructureIndicateur typestructureIndicateur);

    void edit(TypestructureIndicateur typestructureIndicateur);

    void remove(TypestructureIndicateur typestructureIndicateur);

    TypestructureIndicateur find(Object id);

    List<TypestructureIndicateur> findAll();

    List<TypestructureIndicateur> findRange(int[] range);

    int count();

    Long nextVal();

    List<TypestructureIndicateur> findByTypeUo(int idtypestructure) throws Exception;

    TypestructureIndicateur findByTypeUoIndicateur(int idtypeUo, int idindicateur) throws Exception;

}
