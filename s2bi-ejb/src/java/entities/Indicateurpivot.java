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
    @NamedQuery(name = "Indicateurpivot.findAll", query = "SELECT i FROM Indicateurpivot i"),
    @NamedQuery(name = "Indicateurpivot.findByIdindicateurpivot", query = "SELECT i FROM Indicateurpivot i WHERE i.idindicateurpivot = :idindicateurpivot"),
    @NamedQuery(name = "Indicateurpivot.findByCoutunitaire", query = "SELECT i FROM Indicateurpivot i WHERE i.coutunitaire = :coutunitaire")})
public class Indicateurpivot implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idindicateurpivot;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double coutunitaire;
    @JoinColumn(name = "idindicateur", referencedColumnName = "idindicateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Indicateur idindicateur;
    @JoinColumn(name = "idtypeindicateur", referencedColumnName = "idtypeindicateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Typeindicateur idtypeindicateur;

    public Indicateurpivot() {
    }

    public Indicateurpivot(Integer idindicateurpivot) {
        this.idindicateurpivot = idindicateurpivot;
    }

    public Integer getIdindicateurpivot() {
        return idindicateurpivot;
    }

    public void setIdindicateurpivot(Integer idindicateurpivot) {
        this.idindicateurpivot = idindicateurpivot;
    }

    public Double getCoutunitaire() {
        return coutunitaire;
    }

    public void setCoutunitaire(Double coutunitaire) {
        this.coutunitaire = coutunitaire;
    }

    public Indicateur getIdindicateur() {
        return idindicateur;
    }

    public void setIdindicateur(Indicateur idindicateur) {
        this.idindicateur = idindicateur;
    }

    public Typeindicateur getIdtypeindicateur() {
        return idtypeindicateur;
    }

    public void setIdtypeindicateur(Typeindicateur idtypeindicateur) {
        this.idtypeindicateur = idtypeindicateur;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idindicateurpivot != null ? idindicateurpivot.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Indicateurpivot)) {
            return false;
        }
        Indicateurpivot other = (Indicateurpivot) object;
        if ((this.idindicateurpivot == null && other.idindicateurpivot != null) || (this.idindicateurpivot != null && !this.idindicateurpivot.equals(other.idindicateurpivot))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Indicateurpivot[ idindicateurpivot=" + idindicateurpivot + " ]";
    }
    
}
