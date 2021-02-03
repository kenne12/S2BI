/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author USER
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Couverture.findAll", query = "SELECT c FROM Couverture c"),
    @NamedQuery(name = "Couverture.findByIdcouverture", query = "SELECT c FROM Couverture c WHERE c.idcouverture = :idcouverture"),
    @NamedQuery(name = "Couverture.findByValeur", query = "SELECT c FROM Couverture c WHERE c.valeur = :valeur")})
public class Couverture implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idcouverture;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double valeur;
    @JoinColumn(name = "idindicateur", referencedColumnName = "idindicateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Indicateur idindicateur;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;
    @JoinColumn(name = "iduniteorganisation", referencedColumnName = "iduniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Uniteorganisation iduniteorganisation;

    public Couverture() {
    }

    public Couverture(Long idcouverture) {
        this.idcouverture = idcouverture;
    }

    public Long getIdcouverture() {
        return idcouverture;
    }

    public void setIdcouverture(Long idcouverture) {
        this.idcouverture = idcouverture;
    }

    public Double getValeur() {
        return valeur;
    }

    public void setValeur(Double valeur) {
        this.valeur = valeur;
    }

    public Indicateur getIdindicateur() {
        return idindicateur;
    }

    public void setIdindicateur(Indicateur idindicateur) {
        this.idindicateur = idindicateur;
    }

    public Periode getIdperiode() {
        return idperiode;
    }

    public void setIdperiode(Periode idperiode) {
        this.idperiode = idperiode;
    }

    public Uniteorganisation getIduniteorganisation() {
        return iduniteorganisation;
    }

    public void setIduniteorganisation(Uniteorganisation iduniteorganisation) {
        this.iduniteorganisation = iduniteorganisation;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcouverture != null ? idcouverture.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Couverture)) {
            return false;
        }
        Couverture other = (Couverture) object;
        if ((this.idcouverture == null && other.idcouverture != null) || (this.idcouverture != null && !this.idcouverture.equals(other.idcouverture))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Couverture[ idcouverture=" + idcouverture + " ]";
    }
    
}
