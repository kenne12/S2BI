/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Utilisateur;
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
public class UtilisateurFacade extends AbstractFacade<Utilisateur> implements UtilisateurFacadeLocal {

    @PersistenceContext(unitName = "s2bi-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UtilisateurFacade() {
        super(Utilisateur.class);
    }

    @Override
    public Long nextVal() {
        Query query = em.createQuery("SELECT MAX(u.idutilisateur) FROM Utilisateur u");
        Long result = (Long) query.getSingleResult();
        if (result == null) {
            result = 1l;
        } else {
            result += 1l;
        }
        return result;
    }

    @Override
    public Utilisateur login(String login, String password) throws Exception {
        Utilisateur utilisateur = null;
        Query query = em.createQuery("SELECT u FROM Utilisateur U WHERE u.login=:login AND u.password=:password");
        query.setParameter("login", login).setParameter("password", password);
        if (!query.getResultList().isEmpty()) {
            utilisateur = (Utilisateur) query.getResultList().get(0);
        }
        return utilisateur;
    }

    @Override
    public List<Utilisateur> findByActif(Boolean actif) {
        List<Utilisateur> utilisateurs = null;
        Query query = em.createQuery("SELECT u FROM Utilisateur u WHERE u.etat=:actif ORDER BY u.nom,u.prenom");
        query.setParameter("actif", actif);
        utilisateurs = query.getResultList();
        return utilisateurs;
    }

    @Override
    public Utilisateur findByLogin(String login) {
        Query query = em.createQuery("SELECT u FROM Utilisateur u WHERE u.login=:login");
        query.setParameter("login", login);
        List list = query.getResultList();
        if (!list.isEmpty()) {
            return (Utilisateur) list.get(0);
        }
        return null;
    }

}
