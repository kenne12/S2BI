/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Financementbudget;
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
public class FinancementbudgetFacade extends AbstractFacade<Financementbudget> implements FinancementbudgetFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FinancementbudgetFacade() {
        super(Financementbudget.class);
    }

    @Override
    public Long nextVal() {
        Query query = this.em.createQuery("SELECT MAX(f.idfinancementbudget) FROM Financementbudget f");
        Long result = (Long) query.getSingleResult();
        if (result == null) {
            result = 1L;
        } else {
            result += 1l;
        }
        return result;
    }

    @Override
    public Financementbudget findByBailleurTypeUoSousperiode(int idbailleur, int idTypeUo, int idSousPeriode) throws Exception {
        Query query = em.createQuery("SELECT f FROM Financementbudget f WHERE f.idbailleurfond.idbailleurfond=:idbailleur AND f.idtypeUo.idtypeuniteorganisation=:idTypeUo AND f.idsousPeriode.idsousperiode=:idSousPeriode");
        query.setParameter("idbailleur", idbailleur).setParameter("idTypeUo", idTypeUo).setParameter("idSousPeriode", idSousPeriode);
        List<Financementbudget> list = query.getResultList();
        if (!list.isEmpty()) {
            return list.get(0);
        }
        return null;
    }

    @Override
    public List<Financementbudget> findByTypeUoPeriodecostingIdBailleur(int idTypeUo, int idPeriode, int idBailleur) throws Exception {
        Query query = em.createQuery("SELECT f FROM Financementbudget f WHERE f.idtypeUo.idtypeuniteorganisation=:idTypeUo AND  f.idsousPeriode.idperiodecosting.idperiodecosting=:idPc AND f.idbailleurfond.idbailleurfond=:idbailleur");
        query.setParameter("idTypeUo", idTypeUo).setParameter("idPc", idPeriode).setParameter("idbailleur", idBailleur);
        return (List<Financementbudget>) query.getResultList();
    }

    @Override
    public List<Financementbudget> findByBailleurSousperiode(int idbailleur, int idSousPeriode) throws Exception {
        Query query = em.createQuery("SELECT f FROM Financementbudget f WHERE f.idbailleurfond.idbailleurfond=:idbailleur AND f.idsousPeriode.idsousperiode=:idSousPeriode");
        query.setParameter("idbailleur", idbailleur).setParameter("idSousPeriode", idSousPeriode);
        return (List<Financementbudget>) query.getResultList();
    }

    @Override
    public List<Financementbudget> findByBailleurPeriode(int idbailleur, int idPeriode) throws Exception {
        Query query = em.createQuery("SELECT f FROM Financementbudget f WHERE f.idbailleurfond.idbailleurfond=:idbailleur AND f.idsousPeriode.idperiodecosting.idperiodecosting=:idPeriodeC");
        query.setParameter("idbailleur", idbailleur).setParameter("idPeriodeC", idPeriode);
        return (List<Financementbudget>) query.getResultList();
    }

    @Override
    public List<Financementbudget> findBySousperiode(int idSousPeriode) throws Exception {
        Query query = em.createQuery("SELECT f FROM Financementbudget f WHERE f.idsousPeriode.idsousperiode=:idSousPeriode");
        query.setParameter("idSousPeriode", idSousPeriode);
        return (List<Financementbudget>) query.getResultList();
    }

    @Override
    public List<Financementbudget> findByPeriode(int idperiode) throws Exception {
        Query query = em.createQuery("SELECT f FROM Financementbudget f WHERE f.idsousPeriode.idperiodecosting.idperiodecosting=:idPc");
        query.setParameter("idPc", idperiode);
        return (List<Financementbudget>) query.getResultList();
    }

    @Override
    public List<Financementbudget> findByTypeUoIdsousperiode(int idTypeUo, int idSousPeriode) throws Exception {
        Query query = em.createQuery("SELECT f FROM Financementbudget f WHERE f.idtypeUo.idtypeuniteorganisation=:idTypeUo AND f.idsousPeriode.idsousperiode=:idSousPeriode");
        query.setParameter("idTypeUo", idTypeUo).setParameter("idSousPeriode", idSousPeriode);
        return query.getResultList();
    }

    @Override
    public List<Financementbudget> findByTypeUoIdperiode(int idTypeUo, int idPeriode) throws Exception {
        Query query = em.createQuery("SELECT f FROM Financementbudget f WHERE f.idtypeUo.idtypeuniteorganisation=:idTypeUo AND f.idsousPeriode.idperiodecosting.idperiodecosting=:idPeriode");
        query.setParameter("idTypeUo", idTypeUo).setParameter("idPeriode", idPeriode);
        return query.getResultList();
    }

}
