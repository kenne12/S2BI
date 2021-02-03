/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Ciblerealisation;
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
public class CiblerealisationFacade extends AbstractFacade<Ciblerealisation> implements CiblerealisationFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CiblerealisationFacade() {
        super(Ciblerealisation.class);
    }

    @Override
    public Long nextVal() {
        Query query = this.em.createQuery("SELECT MAX(c.idciblerealisation) FROM Ciblerealisation c");
        Long result = (Long) query.getSingleResult();
        if (result == null) {
            result = 1L;
        } else {
            result = result + 1l;
        }
        return result;
    }

    @Override
    public List<Ciblerealisation> findAllBase() throws Exception {
        Query query = em.createQuery("SELECT c FROM Ciblerealisation c WHERE c.idsousperiode.periodedebut=true ORDER BY c.iduniteorganisation.nom");
        return (List<Ciblerealisation>) query.getResultList();
    }
    
    @Override
    public List<Ciblerealisation> findAllBase(boolean costingfosa) throws Exception {
        Query query = em.createQuery("SELECT c FROM Ciblerealisation c WHERE c.idsousperiode.periodedebut=true AND c.iduniteorganisation.costingfosa=:costingfosa ORDER BY c.iduniteorganisation.nom");
        query.setParameter("costingfosa", costingfosa);
        return (List<Ciblerealisation>) query.getResultList();
    }

    @Override
    public List<Ciblerealisation> findByUniteSousPeriode(int idunite, int sousperiode) throws Exception {
        Query query = em.createQuery("SELECT c FROM Ciblerealisation c WHERE c.iduniteorganisation.iduniteorganisation=:idunite AND c.idsousperiode.idsousperiode=:idperiode ORDER BY c.idindicateur.idtypeindicateur.code , c.idindicateur.code");
        return (List<Ciblerealisation>) query.setParameter("idunite", idunite).setParameter("idperiode", sousperiode).getResultList();
    }

    @Override
    public List<Ciblerealisation> findByUnitePeriodeIndicateur(int idunite, int sousperiode, int indicateur) throws Exception {
        Query query = em.createQuery("SELECT c FROM Ciblerealisation c WHERE c.iduniteorganisation.iduniteorganisation=:idunite AND c.idsousperiode.idsousperiode=:idperiode AND c.idindicateur.idindicateur=:indicateur ORDER BY c.idindicateur.idtypeindicateur.code , c.idindicateur.code , c.idperiode.code");
        return (List<Ciblerealisation>) query.setParameter("idunite", idunite).setParameter("idperiode", sousperiode).setParameter("indicateur", indicateur).getResultList();
    }
    
    @Override
    public List<Ciblerealisation> findByUnitePeriodePeriode(int idunite, int idperiode , int idindicateur) throws Exception{
        Query query = em.createQuery("SELECT c FROM Ciblerealisation c WHERE c.iduniteorganisation.iduniteorganisation=:idunite AND c.idsousperiode.idperiodecosting.idperiodecosting=:idperiodeCosting AND c.idindicateur.idindicateur=:idindicateur ORDER BY c.idsousperiode.numero");
        return (List<Ciblerealisation>) query.setParameter("idunite", idunite).setParameter("idperiodeCosting", idperiode).setParameter("idindicateur", idindicateur).getResultList();
    }

}
