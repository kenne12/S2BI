/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.RubriqueScoreQualite;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface RubriqueScoreQualiteFacadeLocal {

    void create(RubriqueScoreQualite rubriqueScoreQualite);

    void edit(RubriqueScoreQualite rubriqueScoreQualite);

    void remove(RubriqueScoreQualite rubriqueScoreQualite);

    RubriqueScoreQualite find(Object id);

    List<RubriqueScoreQualite> findAll();

    List<RubriqueScoreQualite> findRange(int[] range);

    int count();
    
}
