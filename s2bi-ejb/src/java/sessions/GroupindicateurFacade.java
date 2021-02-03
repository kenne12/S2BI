/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Groupindicateur;
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
public class GroupindicateurFacade extends AbstractFacade<Groupindicateur> implements GroupindicateurFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public GroupindicateurFacade() {
        super(Groupindicateur.class);
    }

    @Override
    public Integer nextVal() {
        Query query = em.createQuery("SELECT MAX(g.idgroupindicateur) FROM Groupindicateur g");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result += 1;
        }
        return result;
    }

    @Override
    public List<Groupindicateur> findAllNom() {
        Query query = em.createQuery("SELECT g FROM Groupindicateur g ORDER BY g.nom");
        return (List<Groupindicateur>) query.getResultList();
    }

}
