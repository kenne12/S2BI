/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Privilege;
import entities.TypestructureIndicateur;
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
public class TypestructureIndicateurFacade extends AbstractFacade<TypestructureIndicateur> implements TypestructureIndicateurFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TypestructureIndicateurFacade() {
        super(TypestructureIndicateur.class);
    }

    @Override
    public Long nextVal() {
        Query query = em.createQuery("SELECT MAX(t.idTypestructureIndicateur) FROM TypestructureIndicateur t");
        Long result = (Long) query.getSingleResult();
        if (result == null) {
            result = 1l;
        } else {
            result += 1l;
        }
        return result;
    }

    @Override
    public List<TypestructureIndicateur> findByTypeUo(int idtypestructure) throws Exception {
        Query query = em.createQuery("SELECT t FROM TypestructureIndicateur t WHERE t.idtypestructure.idtypeuniteorganisation=:idtuo");
        query.setParameter("idtuo", idtypestructure);
        return (List<TypestructureIndicateur>) query.getResultList();
    }

    @Override
    public TypestructureIndicateur findByTypeUoIndicateur(int idtypeUo, int idindicateur) throws Exception {
        Query query = em.createQuery("SELECT t FROM TypestructureIndicateur t WHERE t.idtypestructure.idtypeuniteorganisation=:idtypeUo AND t.idindicateur.idindicateur=:idindicateur");
        query.setParameter("idtypeUo", idtypeUo).setParameter("idindicateur", idindicateur);
        List<TypestructureIndicateur> list = query.getResultList();
        if (!list.isEmpty()) {
            return (TypestructureIndicateur) list.get(0);
        }
        return null;
    }

}
