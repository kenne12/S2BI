/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Indicateur;
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
public class IndicateurFacade extends AbstractFacade<Indicateur> implements IndicateurFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public IndicateurFacade() {
        super(Indicateur.class);
    }

    @Override
    public Integer nextVal() {
        Query query = this.em.createQuery("SELECT MAX(i.idindicateur) FROM Indicateur i");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result = result + 1;
        }
        return result;
    }

    @Override
    public List<Indicateur> findAllRange() throws Exception {
        Query query = em.createQuery("SELECT i FROM Indicateur i ORDER BY i.idtypeindicateur.code , i.code");
        return (List<Indicateur>) query.getResultList();
    }

}
