/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.LigneScoreEquite;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author USER
 */
@Stateless
public class LigneScoreEquiteFacade extends AbstractFacade<LigneScoreEquite> implements LigneScoreEquiteFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public LigneScoreEquiteFacade() {
        super(LigneScoreEquite.class);
    }

    @Override
    public Long nextVal() {
        Query query = this.em.createQuery("SELECT MAX(l.idLigneScoreEquite) FROM LigneScoreEquite l");
        Long result = (Long) query.getSingleResult();
        if (result == null) {
            result = 1L;
        } else {
            result = result + 1l;
        }
        return result;
    }

    @Override
    public List<LigneScoreEquite> findByPerioCostingUnite(int idperiode, int idunite) throws Exception {
        Query query = em.createQuery("SELECT l FROM LigneScoreEquite l WHERE l.idcouverture.idsousperiode.idperiodecosting.idperiodecosting=:idperiode AND l.idcouverture.iduniteorganisation.iduniteorganisation=:idunite ORDER BY l.idrubriqueScore.code");
        query.setParameter("idperiode", idperiode).setParameter("idunite", idunite);
        return (List<LigneScoreEquite>) query.getResultList();
    }

    @Override
    public List<LigneScoreEquite> findByPerioCostingUniteBase(int idperiode, int idunite) throws Exception {
        Query query = em.createQuery("SELECT l FROM LigneScoreEquite l WHERE l.idcouverture.idsousperiode.idperiodecosting.idperiodecosting=:idperiode AND l.idcouverture.iduniteorganisation.iduniteorganisation=:idunite AND l.idcouverture.idsousperiode.periodedebut = true ORDER BY l.idrubriqueScore.code");
        query.setParameter("idperiode", idperiode).setParameter("idunite", idunite);
        return (List<LigneScoreEquite>) query.getResultList();
    }

    @Override
    public List<LigneScoreEquite> findByCouvertureRubrique(Long idcouverture, int idrubrique) throws Exception {
        Query query = em.createQuery("SELECT l FROM LigneScoreEquite l WHERE l.idcouverture.idcouverturepopulation=:idcouverture AND l.idrubriqueScore.idRubriqueScoreQualite=:idrubrique");
        query.setParameter("idcouverture", idcouverture).setParameter("idrubrique", idrubrique);
        return (List<LigneScoreEquite>) query.getResultList();
    }

    @Override
    public List<LigneScoreEquite> findByCouverture(Long idcouverture) throws Exception {
        Query query = em.createQuery("SELECT l FROM LigneScoreEquite l WHERE l.idcouverture.idcouverturepopulation=:idcouverture ORDER BY l.idrubriqueScore.code");
        query.setParameter("idcouverture", idcouverture);
        return (List<LigneScoreEquite>) query.getResultList();
    }

}
