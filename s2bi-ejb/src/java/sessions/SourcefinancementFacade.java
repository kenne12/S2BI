/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Sourcefinancement;
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
public class SourcefinancementFacade extends AbstractFacade<Sourcefinancement> implements SourcefinancementFacadeLocal {
    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SourcefinancementFacade() {
        super(Sourcefinancement.class);
    }
    
    @Override
    public Integer nextVal() {
        Query query = em.createQuery("SELECT MAX(s.idsourcefinancement) FROM Sourcefinancement s");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result += 1;
        }
        return result;
    }

    @Override
    public List<Sourcefinancement> findAllNom() {
        Query query = em.createQuery("SELECT s FROM Sourcefinancement s ORDER BY s.nom");
        return (List<Sourcefinancement>) query.getResultList();
    }
    
}
