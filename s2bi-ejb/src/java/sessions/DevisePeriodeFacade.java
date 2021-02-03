/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.DevisePeriode;
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
public class DevisePeriodeFacade extends AbstractFacade<DevisePeriode> implements DevisePeriodeFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DevisePeriodeFacade() {
        super(DevisePeriode.class);
    }

    @Override
    public Integer nextVal() {
        Query query = this.em.createQuery("SELECT MAX(d.iddevisePeriode) FROM DevisePeriode d");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result = result + 1;
        }
        return result;
    }

    @Override
    public List<DevisePeriode> findAllRange() {
        Query query = em.createQuery("SELECT d FROM DevisePeriode d ORDER BY d.idperiode.code , d.iddevise.code");
        return query.getResultList();
    }

    @Override
    public List<DevisePeriode> findByIddevise(int iddevise) throws Exception {
        Query query = em.createQuery("SELECT d FROM DevisePeriode d WHERE d.iddevise.iddevise=:iddevise ORDER BY d.idperiode.code");
        query.setParameter("iddevise", iddevise);
        return query.getResultList();
    }

    @Override
    public DevisePeriode findByIddevise(int iddevise, int idperiode) throws Exception {
        Query query = em.createQuery("SELECT d FROM DevisePeriode d WHERE d.iddevise.iddevise=:iddevise AND d.idperiode.idperiode=:idperiode");
        query.setParameter("iddevise", iddevise).setParameter("idperiode", idperiode);
        List<DevisePeriode> list = query.getResultList();
        if (!list.isEmpty()) {
            return list.get(0);
        }
        return null;
    }

}
