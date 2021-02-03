/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Financement;
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
public class FinancementFacade extends AbstractFacade<Financement> implements FinancementFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FinancementFacade() {
        super(Financement.class);
    }

    @Override
    public Long nextVal() {
        Query query = em.createQuery("SELECT MAX(f.idfinancement) FROM Financement f");
        Long result = (Long) query.getSingleResult();
        if (result == null) {
            result = 1L;
        } else {
            result += 1;
        }
        return result;
    }

    @Override
    public List<Financement> findAllRange() {
        Query query = em.createQuery("SELECT f FROM Financement f ORDER BY f.idsousPeriode.idperiodecosting.libelle,f.idsousPeriode.numero,f.idbailleurfond.code");
        return (List<Financement>) query.getResultList();
    }

    @Override
    public List<Financement> findBySousPeriodeTypeUo(int idsousperiode, int idtypeUo) throws Exception {
        Query query = em.createQuery("SELECT f FROM Financement f WHERE f.idsousPeriode.idsousperiode=:idsousperiode AND f.idtypeuniteorganisation.idtypeuniteorganisation=:idtypeUo");
        query.setParameter("idsousperiode", idsousperiode).setParameter("idtypeUo", idtypeUo);
        return (List<Financement>) query.getResultList();
    }
    
    @Override
    public List<Financement> findBySousPeriode(int idsousperiode) throws Exception {
        Query query = em.createQuery("SELECT f FROM Financement f WHERE f.idsousPeriode.idsousperiode=:idsousperiode");
        query.setParameter("idsousperiode", idsousperiode);
        return (List<Financement>) query.getResultList();
    }

}
