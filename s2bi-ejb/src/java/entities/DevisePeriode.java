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
@Table(name = "devise_periode")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "DevisePeriode.findAll", query = "SELECT d FROM DevisePeriode d"),
    @NamedQuery(name = "DevisePeriode.findByIddevisePeriode", query = "SELECT d FROM DevisePeriode d WHERE d.iddevisePeriode = :iddevisePeriode"),
    @NamedQuery(name = "DevisePeriode.findByValeur", query = "SELECT d FROM DevisePeriode d WHERE d.valeur = :valeur")})
public class DevisePeriode implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "iddevise_periode")
    private Integer iddevisePeriode;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double valeur;
    @JoinColumn(name = "iddevise", referencedColumnName = "iddevise")
    @ManyToOne(fetch = FetchType.LAZY)
    private Devise iddevise;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;

    public DevisePeriode() {
    }

    public DevisePeriode(Integer iddevisePeriode) {
        this.iddevisePeriode = iddevisePeriode;
    }

    public Integer getIddevisePeriode() {
        return iddevisePeriode;
    }

    public void setIddevisePeriode(Integer iddevisePeriode) {
        this.iddevisePeriode = iddevisePeriode;
    }

    public Double getValeur() {
        return valeur;
    }

    public void setValeur(Double valeur) {
        this.valeur = valeur;
    }

    public Devise getIddevise() {
        return iddevise;
    }

    public void setIddevise(Devise iddevise) {
        this.iddevise = iddevise;
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
        hash += (iddevisePeriode != null ? iddevisePeriode.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DevisePeriode)) {
            return false;
        }
        DevisePeriode other = (DevisePeriode) object;
        if ((this.iddevisePeriode == null && other.iddevisePeriode != null) || (this.iddevisePeriode != null && !this.iddevisePeriode.equals(other.iddevisePeriode))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.DevisePeriode[ iddevisePeriode=" + iddevisePeriode + " ]";
    }
    
}
