/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Uniteorganisation;
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
public class UniteorganisationFacade extends AbstractFacade<Uniteorganisation> implements UniteorganisationFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UniteorganisationFacade() {
        super(Uniteorganisation.class);
    }

    @Override
    public Integer nextVal() {
        Query query = this.em.createQuery("SELECT MAX(u.iduniteorganisation) FROM Uniteorganisation u");
        Integer result = (Integer) query.getSingleResult();
        if (result == null) {
            result = 1;
        } else {
            result = result + 1;
        }
        return result;
    }

    @Override
    public List<Uniteorganisation> findParentOrganisation() throws Exception {
        Query query = this.em.createQuery("SELECT u FROM Uniteorganisation u WHERE u.idparent=0");
        return query.getResultList();
    }

    @Override
    public List<Uniteorganisation> findAllRange() throws Exception {
        Query query = this.em.createQuery("SELECT u FROM Uniteorganisation u ORDER BY u.nom");
        return query.getResultList();
    }

    @Override
    public List<Uniteorganisation> findAllRange(boolean costingfosa) throws Exception {
        Query query = this.em.createQuery("SELECT u FROM Uniteorganisation u WHERE u.costingfosa=:costingfosa ORDER BY u.nom");
        query.setParameter("costingfosa", costingfosa);
        return query.getResultList();

    }

    @Override
    public List<Uniteorganisation> findByOrganisationUnitParent(int idparent) throws Exception {
        Query query = this.em.createQuery("SELECT u FROM Uniteorganisation u  WHERE u.idparent!=0 AND u.idparent=:idparent ORDER BY u.nom");
        query.setParameter("idparent", idparent);
        return query.getResultList();
    }

    @Override
    public List<Uniteorganisation> findByTypeUo(int idTyoeUo) throws Exception {
        Query query = this.em.createQuery("SELECT u FROM Uniteorganisation u  WHERE u.idtypeuniteorganisation.idtypeuniteorganisation=:idTypeUo ORDER BY u.nom");
        query.setParameter("idTypeUo", idTyoeUo);
        return query.getResultList();
    }

}
