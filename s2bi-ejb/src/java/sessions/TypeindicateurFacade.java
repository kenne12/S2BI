/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Groupindicateur;
import entities.Typeindicateur;
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
public class TypeindicateurFacade extends AbstractFacade<Typeindicateur> implements TypeindicateurFacadeLocal {
    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TypeindicateurFacade() {
        super(Typeindicateur.class);
    }
    
    @Override
    public Integer nextVal() {
        Query query = em.createQuery("SELECT MAX(t.idtypeindicateur) FROM Typeindicateur t");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result += 1;
        }
        return result;
    }

    @Override
    public List<Typeindicateur> findAllNom() {
        Query query = em.createQuery("SELECT t FROM Typeindicateur t ORDER BY t.nom");
        return (List<Typeindicateur>) query.getResultList();
    }
    
}
