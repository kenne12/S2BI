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
    @NamedQuery(name = "Cibleannuelle.findAll", query = "SELECT c FROM Cibleannuelle c"),
    @NamedQuery(name = "Cibleannuelle.findByIdcibleannuelle", query = "SELECT c FROM Cibleannuelle c WHERE c.idcibleannuelle = :idcibleannuelle"),
    @NamedQuery(name = "Cibleannuelle.findByValeur", query = "SELECT c FROM Cibleannuelle c WHERE c.valeur = :valeur")})
public class Cibleannuelle implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idcibleannuelle;
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

    public Cibleannuelle() {
    }

    public Cibleannuelle(Long idcibleannuelle) {
        this.idcibleannuelle = idcibleannuelle;
    }

    public Long getIdcibleannuelle() {
        return idcibleannuelle;
    }

    public void setIdcibleannuelle(Long idcibleannuelle) {
        this.idcibleannuelle = idcibleannuelle;
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
        hash += (idcibleannuelle != null ? idcibleannuelle.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cibleannuelle)) {
            return false;
        }
        Cibleannuelle other = (Cibleannuelle) object;
        if ((this.idcibleannuelle == null && other.idcibleannuelle != null) || (this.idcibleannuelle != null && !this.idcibleannuelle.equals(other.idcibleannuelle))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Cibleannuelle[ idcibleannuelle=" + idcibleannuelle + " ]";
    }
    
}
