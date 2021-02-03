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
    @NamedQuery(name = "Coutunitaireindicateur.findAll", query = "SELECT c FROM Coutunitaireindicateur c"),
    @NamedQuery(name = "Coutunitaireindicateur.findByIdcoutunitaireindicateur", query = "SELECT c FROM Coutunitaireindicateur c WHERE c.idcoutunitaireindicateur = :idcoutunitaireindicateur"),
    @NamedQuery(name = "Coutunitaireindicateur.findByCout", query = "SELECT c FROM Coutunitaireindicateur c WHERE c.cout = :cout")})
public class Coutunitaireindicateur implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idcoutunitaireindicateur;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double cout;
    @JoinColumn(name = "idindicateur", referencedColumnName = "idindicateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Indicateur idindicateur;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;

    public Coutunitaireindicateur() {
    }

    public Coutunitaireindicateur(Long idcoutunitaireindicateur) {
        this.idcoutunitaireindicateur = idcoutunitaireindicateur;
    }

    public Long getIdcoutunitaireindicateur() {
        return idcoutunitaireindicateur;
    }

    public void setIdcoutunitaireindicateur(Long idcoutunitaireindicateur) {
        this.idcoutunitaireindicateur = idcoutunitaireindicateur;
    }

    public Double getCout() {
        return cout;
    }

    public void setCout(Double cout) {
        this.cout = cout;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcoutunitaireindicateur != null ? idcoutunitaireindicateur.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Coutunitaireindicateur)) {
            return false;
        }
        Coutunitaireindicateur other = (Coutunitaireindicateur) object;
        if ((this.idcoutunitaireindicateur == null && other.idcoutunitaireindicateur != null) || (this.idcoutunitaireindicateur != null && !this.idcoutunitaireindicateur.equals(other.idcoutunitaireindicateur))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Coutunitaireindicateur[ idcoutunitaireindicateur=" + idcoutunitaireindicateur + " ]";
    }
    
}
