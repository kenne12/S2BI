/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Devise;
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
public class DeviseFacade extends AbstractFacade<Devise> implements DeviseFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DeviseFacade() {
        super(Devise.class);
    }

    @Override
    public Integer nextVal() {
        Query query = em.createQuery("SELECT MAX(d.iddevise) FROM Devise d");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result += 1;
        }
        return result;
    }

    @Override
    public List<Devise> findAllNom() {
        Query query = em.createQuery("SELECT d FROM Devise d ORDER BY d.nom");
        return (List<Devise>) query.getResultList();
    }

}
