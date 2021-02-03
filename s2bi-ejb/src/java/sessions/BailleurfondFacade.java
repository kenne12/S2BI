/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Bailleurfond;
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
public class BailleurfondFacade extends AbstractFacade<Bailleurfond> implements BailleurfondFacadeLocal {
    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public BailleurfondFacade() {
        super(Bailleurfond.class);
    }
    
    @Override
    public Integer nextVal() {
        Query query = em.createQuery("SELECT MAX(b.idbailleurfond) FROM Bailleurfond b");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result += 1;
        }
        return result;
    }

    @Override
    public List<Bailleurfond> findAllNom() {
        Query query = em.createQuery("SELECT b FROM Bailleurfond b ORDER BY b.nom");
        return (List<Bailleurfond>) query.getResultList();
    }
    
}
