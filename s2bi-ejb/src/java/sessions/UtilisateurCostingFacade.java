/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.UtilisateurCosting;
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
public class UtilisateurCostingFacade extends AbstractFacade<UtilisateurCosting> implements UtilisateurCostingFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UtilisateurCostingFacade() {
        super(UtilisateurCosting.class);
    }

    @Override
    public Long nextVal() {
        Query query = em.createQuery("SELECT MAX(u.idUtilisateurCosting) FROM UtilisateurCosting u");
        Long result = (Long) query.getSingleResult();
        if (result == null) {
            result = 1l;
        } else {
            result += 1l;
        }
        return result;
    }

    @Override
    public List<UtilisateurCosting> findByUtilisateur(Long idutilisateur) throws Exception {
        Query query = em.createQuery("SELECT u FROM UtilisateurCosting u WHERE u.idutilisateur.idutilisateur=:iduser");
        query.setParameter("iduser", idutilisateur);
        return (List<UtilisateurCosting>) query.getResultList();
    }

    @Override
    public UtilisateurCosting findByUserCosting(Long iduser, int idcosting) throws Exception {
        Query query = em.createQuery("SELECT u FROM UtilisateurCosting u WHERE u.idutilisateur.idutilisateur=:iduser AND u.idperiodeCosting.idperiodecosting=:idcosting");
        query.setParameter("iduser", iduser).setParameter("idcosting", idcosting);
        List<UtilisateurCosting> list = query.getResultList();
        if (!list.isEmpty()) {
            return (UtilisateurCosting) list.get(0);
        }
        return null;
    }

}
