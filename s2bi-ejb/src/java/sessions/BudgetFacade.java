/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Budget;
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
public class BudgetFacade extends AbstractFacade<Budget> implements BudgetFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public BudgetFacade() {
        super(Budget.class);
    }

    @Override
    public Long nextVal() {
        Query query = this.em.createQuery("SELECT MAX(b.idbudget) FROM Budget b");
        Long result = (Long) query.getSingleResult();
        if (result == null) {
            result = 1L;
        } else {
            result += 1l;
        }
        return result;
    }

    @Override
    public List<Budget> findByUnitePeriodecosting(int idunite, int idperiodecosting) throws Exception {
        Query query = em.createQuery("SELECT b FROM Budget b WHERE b.idsousPeriode.idperiodecosting.idperiodecosting=:idperiodecosting AND b.iduniteorganisation.iduniteorganisation=:idunite ORDER BY b.idindicateur.code");
        query.setParameter("idperiodecosting", idperiodecosting).setParameter("idunite", idunite);
        return (List<Budget>) query.getResultList();
    }

    @Override
    public List<Budget> findByUniteSousPeriodecosting(int idunite, int idsousperiode) throws Exception {
        Query query = em.createQuery("SELECT b FROM Budget b WHERE b.idsousPeriode.idsousperiode=:idsousperiodecosting AND b.iduniteorganisation.iduniteorganisation=:idunite ORDER BY b.idindicateur.code");
        query.setParameter("idsousperiodecosting", idsousperiode).setParameter("idunite", idunite);
        return (List<Budget>) query.getResultList();
    }

    @Override
    public List<Budget> findByUniteIndicateurSousperiode(int idunite, int idindicateur, int idsousperiode) throws Exception {
        Query query = em.createQuery("SELECT b FROM Budget b WHERE b.idsousPeriode.idsousperiode=:idsousperiodecosting AND b.iduniteorganisation.iduniteorganisation=:idunite AND b.idindicateur.idindicateur=:idindicateur");
        query.setParameter("idsousperiodecosting", idsousperiode).setParameter("idunite", idunite).setParameter("idindicateur", idindicateur);
        return (List<Budget>) query.getResultList();
    }

    @Override
    public List<Budget> findByUniteIndicateurPeriode(int idunite, int idindicateur, int idperiode) throws Exception {
        Query query = em.createQuery("SELECT b FROM Budget b WHERE b.idsousPeriode.idperiodecosting.idperiodecosting=:idPeriodeC AND b.iduniteorganisation.iduniteorganisation=:idunite AND b.idindicateur.idindicateur=:idindicateur");
        query.setParameter("idPeriodeC", idperiode).setParameter("idunite", idunite).setParameter("idindicateur", idindicateur);
        return (List<Budget>) query.getResultList();
    }

    @Override
    public List<Budget> findByUniteSousperiode(int idunite, int idsousperiode) throws Exception {
        Query query = em.createQuery("SELECT b FROM Budget b WHERE b.idsousPeriode.idsousperiode=:idsousperiodecosting AND b.iduniteorganisation.iduniteorganisation=:idunite");
        query.setParameter("idsousperiodecosting", idsousperiode).setParameter("idunite", idunite);
        return (List<Budget>) query.getResultList();
    }

    @Override
    public List<Budget> findByTypeUoSousperiode(int idTypeUo, int idsousperiode) throws Exception {
        Query query = em.createQuery("SELECT b FROM Budget b WHERE b.idsousPeriode.idsousperiode=:idsousperiodecosting AND b.iduniteorganisation.idtypeuniteorganisation.idtypeuniteorganisation=:idTypeUo");
        query.setParameter("idsousperiodecosting", idsousperiode).setParameter("idTypeUo", idTypeUo);
        return query.getResultList();
    }

    @Override
    public List<Budget> findByTypeUoPeriodecosting(int idTypeUo, int idperiodecosting) throws Exception {
        Query query = em.createQuery("SELECT b FROM Budget b WHERE b.idsousPeriode.idperiodecosting.idperiodecosting=:idperiodeCosting AND b.iduniteorganisation.idtypeuniteorganisation.idtypeuniteorganisation=:idTypeUo");
        query.setParameter("idperiodeCosting", idperiodecosting).setParameter("idTypeUo", idTypeUo);
        return query.getResultList();
    }

    @Override
    public List<Budget> findByPeriodecosting(int idperiodecosting) throws Exception {
        Query query = em.createQuery("SELECT b FROM Budget b WHERE b.idsousPeriode.idperiodecosting.idperiodecosting=:idperiodeCosting");
        query.setParameter("idperiodeCosting", idperiodecosting);
        return query.getResultList();
    }

    @Override
    public List<Budget> findBySousperiode(int idsousperiode) throws Exception {
        Query query = em.createQuery("SELECT b FROM Budget b WHERE b.idsousPeriode.idsousperiode=:idsousperiodecosting");
        query.setParameter("idsousperiodecosting", idsousperiode);
        return query.getResultList();
    }

}
