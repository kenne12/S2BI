/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Groupindicateur;
import entities.Niveaupyramide;
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
public class NiveaupyramideFacade extends AbstractFacade<Niveaupyramide> implements NiveaupyramideFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public NiveaupyramideFacade() {
        super(Niveaupyramide.class);
    }

    @Override
    public Integer nextVal() {
        Query query = em.createQuery("SELECT MAX(n.idniveaupyramide) FROM Niveaupyramide n");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result += 1;
        }
        return result;
    }

    @Override
    public List<Niveaupyramide> findAllNumero() {
        Query query = em.createQuery("SELECT n FROM Niveaupyramide n ORDER BY n.numero");
        return (List<Niveaupyramide>) query.getResultList();
    }

}
