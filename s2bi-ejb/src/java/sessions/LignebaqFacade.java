/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Lignebaq;
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
public class LignebaqFacade extends AbstractFacade<Lignebaq> implements LignebaqFacadeLocal {
    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public LignebaqFacade() {
        super(Lignebaq.class);
    }
    
    @Override
    public Long nextVal() {
        Query query = this.em.createQuery("SELECT MAX(l.idLignebaq) FROM Lignebaq l");
        Long result = (Long) query.getSingleResult();
        if (result == null) {
            result = 1L;
        } else {
            result = result + 1l;
        }
        return result;
    }

    @Override
    public List<Lignebaq> findByPerioCostingUnite(int idperiode, int idunite) throws Exception {
        Query query = em.createQuery("SELECT l FROM Lignebaq l WHERE l.idcouverture.idsousperiode.idperiodecosting.idperiodecosting=:idperiode AND l.idcouverture.iduniteorganisation.iduniteorganisation=:idunite ORDER BY l.idTypeBaq.code");
        query.setParameter("idperiode", idperiode).setParameter("idunite", idunite);
        return (List<Lignebaq>) query.getResultList();
    }

    @Override
    public List<Lignebaq> findByPerioCostingUniteBase(int idperiode, int idunite) throws Exception {
        Query query = em.createQuery("SELECT l FROM Lignebaq l WHERE l.idcouverture.idsousperiode.idperiodecosting.idperiodecosting=:idperiode AND l.idcouverture.iduniteorganisation.iduniteorganisation=:idunite AND l.idcouverture.idsousperiode.periodedebut = true ORDER BY l.idTypeBaq.code");
        query.setParameter("idperiode", idperiode).setParameter("idunite", idunite);
        return (List<Lignebaq>) query.getResultList();
    }

    @Override
    public List<Lignebaq> findByCouvertureRubrique(Long idcouverture, int idtypebaq) throws Exception {
        Query query = em.createQuery("SELECT l FROM Lignebaq l WHERE l.idcouverture.idcouverturepopulation=:idcouverture AND l.idTypeBaq.idTypeBaq=:idtypebaq");
        query.setParameter("idcouverture", idcouverture).setParameter("idtypebaq", idtypebaq);
        return (List<Lignebaq>) query.getResultList();
    }

    @Override
    public List<Lignebaq> findByCouverture(Long idcouverture) throws Exception {
        Query query = em.createQuery("SELECT l FROM Lignebaq l WHERE l.idcouverture.idcouverturepopulation=:idcouverture ORDER BY l.idTypeBaq.code");
        query.setParameter("idcouverture", idcouverture);
        return (List<Lignebaq>) query.getResultList();
    }
    
}
