/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.TypeBaq;
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
public class TypeBaqFacade extends AbstractFacade<TypeBaq> implements TypeBaqFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TypeBaqFacade() {
        super(TypeBaq.class);
    }

    @Override
    public List<TypeBaq> findAllRangeCode() {
        Query query = em.createQuery("SELECT t FROM TypeBaq t ORDER BY t.code");
        return (List<TypeBaq>) query.getResultList();
    }

}
