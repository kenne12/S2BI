/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Couverturepopulation;
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
public class CouverturepopulationFacade extends AbstractFacade<Couverturepopulation> implements CouverturepopulationFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CouverturepopulationFacade() {
        super(Couverturepopulation.class);
    }

    @Override
    public Long nextVal() {
        Query query = em.createQuery("SELECT MAX(c.idcouverturepopulation) FROM Couverturepopulation c");
        Long result = (Long) query.getSingleResult();
        if (result == null) {
            result = 1L;
        } else {
            result += 1;
        }
        return result;
    }

    @Override
    public List<Couverturepopulation> findByUnite(int uniteOrganisation) throws Exception {
        Query query = em.createQuery("SELECT c FROM Couverturepopulation c WHERE c.iduniteorganisation.iduniteorganisation=:unite ORDER BY c.idperiode.code");
        return query.setParameter("unite", uniteOrganisation).getResultList();
    }

    @Override
    public List<Couverturepopulation> findAllRange() throws Exception {
        Query query = em.createQuery("SELECT c FROM Couverturepopulation c ORDER BY c.iduniteorganisation.code, c.idsousperiode.numero");
        return query.getResultList();
    }

    @Override
    public List<Couverturepopulation> findByPeriodeCostingUnite(int periodeCosting, int uniteOrganisation) throws Exception {
        Query query = em.createQuery("SELECT c FROM Couverturepopulation c WHERE c.iduniteorganisation.iduniteorganisation=:unite AND c.idsousperiode.idperiodecosting.idperiodecosting=:pc ORDER BY c.idsousperiode.numero");
        return query.setParameter("unite", uniteOrganisation).setParameter("pc", periodeCosting).getResultList();
    }

    @Override
    public Couverturepopulation findBySousPeriodeCostingUnite(int sousperiodeCosting, int uniteOrganisation) throws Exception {
        Query query = em.createQuery("SELECT c FROM Couverturepopulation c WHERE c.iduniteorganisation.iduniteorganisation=:unite AND c.idsousperiode.idsousperiode=:spc ORDER BY c.idsousperiode.numero");
        List<Couverturepopulation> list = query.setParameter("unite", uniteOrganisation).setParameter("spc", sousperiodeCosting).getResultList();
        if (!list.isEmpty()) {
            return list.get(0);
        }
        return null;
    }

    @Override
    public List<Couverturepopulation> findBySousPeriodeCostingUniteParent(int sousperiodeCosting, int uniteParent) throws Exception {
        Query query = em.createQuery("SELECT c FROM Couverturepopulation c WHERE c.iduniteorganisation.idparent=:idparent AND c.idsousperiode.idsousperiode=:spc ORDER BY c.idsousperiode.numero");
        return query.setParameter("idparent", uniteParent).setParameter("spc", sousperiodeCosting).getResultList();
    }

}
