/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.LigneScoreEquite;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface LigneScoreEquiteFacadeLocal {

    void create(LigneScoreEquite ligneScoreEquite);

    void edit(LigneScoreEquite ligneScoreEquite);

    void remove(LigneScoreEquite ligneScoreEquite);

    LigneScoreEquite find(Object id);

    List<LigneScoreEquite> findAll();

    List<LigneScoreEquite> findRange(int[] range);

    int count();

    Long nextVal();

    List<LigneScoreEquite> findByPerioCostingUnite(int idperiode, int idunite) throws Exception;
    
    List<LigneScoreEquite> findByPerioCostingUniteBase(int idperiode, int idunite) throws Exception;

    List<LigneScoreEquite> findByCouvertureRubrique(Long idcouverture, int idrubrique) throws Exception;
    
    List<LigneScoreEquite> findByCouverture(Long idcouverture) throws Exception;

}
