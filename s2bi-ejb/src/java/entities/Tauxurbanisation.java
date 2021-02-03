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
    @NamedQuery(name = "Tauxurbanisation.findAll", query = "SELECT t FROM Tauxurbanisation t"),
    @NamedQuery(name = "Tauxurbanisation.findByIdtauxurbanisation", query = "SELECT t FROM Tauxurbanisation t WHERE t.idtauxurbanisation = :idtauxurbanisation"),
    @NamedQuery(name = "Tauxurbanisation.findByValeur", query = "SELECT t FROM Tauxurbanisation t WHERE t.valeur = :valeur")})
public class Tauxurbanisation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idtauxurbanisation;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double valeur;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;
    @JoinColumn(name = "iduniteorganisation", referencedColumnName = "iduniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Uniteorganisation iduniteorganisation;

    public Tauxurbanisation() {
    }

    public Tauxurbanisation(Integer idtauxurbanisation) {
        this.idtauxurbanisation = idtauxurbanisation;
    }

    public Integer getIdtauxurbanisation() {
        return idtauxurbanisation;
    }

    public void setIdtauxurbanisation(Integer idtauxurbanisation) {
        this.idtauxurbanisation = idtauxurbanisation;
    }

    public Double getValeur() {
        return valeur;
    }

    public void setValeur(Double valeur) {
        this.valeur = valeur;
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
        hash += (idtauxurbanisation != null ? idtauxurbanisation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tauxurbanisation)) {
            return false;
        }
        Tauxurbanisation other = (Tauxurbanisation) object;
        if ((this.idtauxurbanisation == null && other.idtauxurbanisation != null) || (this.idtauxurbanisation != null && !this.idtauxurbanisation.equals(other.idtauxurbanisation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Tauxurbanisation[ idtauxurbanisation=" + idtauxurbanisation + " ]";
    }
    
}
