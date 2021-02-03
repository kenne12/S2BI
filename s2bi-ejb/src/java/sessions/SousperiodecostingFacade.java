/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Periodecosting;
import entities.Sousperiodecosting;
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
public class SousperiodecostingFacade extends AbstractFacade<Sousperiodecosting> implements SousperiodecostingFacadeLocal {
    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SousperiodecostingFacade() {
        super(Sousperiodecosting.class);
    }
    
    @Override
    public Integer nextVal() {
        Query query = em.createQuery("SELECT MAX(s.idsousperiode) FROM Sousperiodecosting s");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result += 1;
        }
        return result;
    }

    @Override
    public List<Sousperiodecosting> findAllNom() {
        Query query = em.createQuery("SELECT s FROM Sousperiodecosting s ORDER BY s.numero");
        return (List<Sousperiodecosting>) query.getResultList();
    }
    
    @Override
    public List<Sousperiodecosting> findByPeriodeCosting(int idPeriodeCosting) throws Exception{
        Query query = em.createQuery("SELECT s FROM Sousperiodecosting s WHERE s.idperiodecosting.idperiodecosting=:idperiodecosting ORDER BY s.numero").setParameter("idperiodecosting", idPeriodeCosting);
        return (List<Sousperiodecosting>)query.getResultList();
    }
    
    
    @Override
    public List<Sousperiodecosting> findByPeriodeCostingBase(int idPeriodeCosting , boolean periode_debut) throws Exception{
        Query query = em.createQuery("SELECT s FROM Sousperiodecosting s WHERE s.idperiodecosting.idperiodecosting=:idperiodecosting AND s.periodedebut=:debut ORDER BY s.numero").setParameter("idperiodecosting", idPeriodeCosting).setParameter("debut", periode_debut);
        return (List<Sousperiodecosting>)query.getResultList();
    }
    
}
