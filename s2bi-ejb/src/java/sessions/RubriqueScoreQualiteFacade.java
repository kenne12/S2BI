/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.RubriqueScoreQualite;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author USER
 */
@Stateless
public class RubriqueScoreQualiteFacade extends AbstractFacade<RubriqueScoreQualite> implements RubriqueScoreQualiteFacadeLocal {
    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RubriqueScoreQualiteFacade() {
        super(RubriqueScoreQualite.class);
    }
    
}
