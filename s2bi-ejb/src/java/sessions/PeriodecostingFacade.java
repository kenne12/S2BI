/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Periodecosting;
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
public class PeriodecostingFacade extends AbstractFacade<Periodecosting> implements PeriodecostingFacadeLocal {
    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PeriodecostingFacade() {
        super(Periodecosting.class);
    }
    
    @Override
    public Integer nextVal() {
        Query query = em.createQuery("SELECT MAX(p.idperiodecosting) FROM Periodecosting p");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result += 1;
        }
        return result;
    }

    @Override
    public List<Periodecosting> findAllNom() {
        Query query = em.createQuery("SELECT p FROM Periodecosting p ORDER BY p.libelle");
        return (List<Periodecosting>) query.getResultList();
    }
    
}
