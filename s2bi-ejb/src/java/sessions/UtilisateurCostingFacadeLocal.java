/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.UtilisateurCosting;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface UtilisateurCostingFacadeLocal {

    void create(UtilisateurCosting utilisateurCosting);

    void edit(UtilisateurCosting utilisateurCosting);

    void remove(UtilisateurCosting utilisateurCosting);

    UtilisateurCosting find(Object id);

    List<UtilisateurCosting> findAll();

    List<UtilisateurCosting> findRange(int[] range);

    int count();

    Long nextVal();

    List<UtilisateurCosting> findByUtilisateur(Long idutilisateur) throws Exception;

    UtilisateurCosting findByUserCosting(Long iduser, int idcosting) throws Exception;

}
