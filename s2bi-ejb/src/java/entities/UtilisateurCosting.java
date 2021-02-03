/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author USER
 */
@Entity
@Table(name = "utilisateur_costing")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UtilisateurCosting.findAll", query = "SELECT u FROM UtilisateurCosting u"),
    @NamedQuery(name = "UtilisateurCosting.findByIdUtilisateurCosting", query = "SELECT u FROM UtilisateurCosting u WHERE u.idUtilisateurCosting = :idUtilisateurCosting")})
public class UtilisateurCosting implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_utilisateur_costing")
    private Long idUtilisateurCosting;
    @JoinColumn(name = "idperiode_costing", referencedColumnName = "idperiodecosting")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periodecosting idperiodeCosting;
    @JoinColumn(name = "idutilisateur", referencedColumnName = "idutilisateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Utilisateur idutilisateur;

    public UtilisateurCosting() {
    }

    public UtilisateurCosting(Long idUtilisateurCosting) {
        this.idUtilisateurCosting = idUtilisateurCosting;
    }

    public Long getIdUtilisateurCosting() {
        return idUtilisateurCosting;
    }

    public void setIdUtilisateurCosting(Long idUtilisateurCosting) {
        this.idUtilisateurCosting = idUtilisateurCosting;
    }

    public Periodecosting getIdperiodeCosting() {
        return idperiodeCosting;
    }

    public void setIdperiodeCosting(Periodecosting idperiodeCosting) {
        this.idperiodeCosting = idperiodeCosting;
    }

    public Utilisateur getIdutilisateur() {
        return idutilisateur;
    }

    public void setIdutilisateur(Utilisateur idutilisateur) {
        this.idutilisateur = idutilisateur;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idUtilisateurCosting != null ? idUtilisateurCosting.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UtilisateurCosting)) {
            return false;
        }
        UtilisateurCosting other = (UtilisateurCosting) object;
        if ((this.idUtilisateurCosting == null && other.idUtilisateurCosting != null) || (this.idUtilisateurCosting != null && !this.idUtilisateurCosting.equals(other.idUtilisateurCosting))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.UtilisateurCosting[ idUtilisateurCosting=" + idUtilisateurCosting + " ]";
    }
    
}
