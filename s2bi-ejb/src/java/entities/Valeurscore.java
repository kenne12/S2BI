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
    @NamedQuery(name = "Valeurscore.findAll", query = "SELECT v FROM Valeurscore v"),
    @NamedQuery(name = "Valeurscore.findByIdvaleurscore", query = "SELECT v FROM Valeurscore v WHERE v.idvaleurscore = :idvaleurscore"),
    @NamedQuery(name = "Valeurscore.findByValeur", query = "SELECT v FROM Valeurscore v WHERE v.valeur = :valeur")})
public class Valeurscore implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idvaleurscore;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double valeur;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;
    @JoinColumn(name = "idtypescore", referencedColumnName = "idtypescore")
    @ManyToOne(fetch = FetchType.LAZY)
    private Typescore idtypescore;
    @JoinColumn(name = "iduniteorganisation", referencedColumnName = "iduniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Uniteorganisation iduniteorganisation;

    public Valeurscore() {
    }

    public Valeurscore(Integer idvaleurscore) {
        this.idvaleurscore = idvaleurscore;
    }

    public Integer getIdvaleurscore() {
        return idvaleurscore;
    }

    public void setIdvaleurscore(Integer idvaleurscore) {
        this.idvaleurscore = idvaleurscore;
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

    public Typescore getIdtypescore() {
        return idtypescore;
    }

    public void setIdtypescore(Typescore idtypescore) {
        this.idtypescore = idtypescore;
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
        hash += (idvaleurscore != null ? idvaleurscore.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Valeurscore)) {
            return false;
        }
        Valeurscore other = (Valeurscore) object;
        if ((this.idvaleurscore == null && other.idvaleurscore != null) || (this.idvaleurscore != null && !this.idvaleurscore.equals(other.idvaleurscore))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Valeurscore[ idvaleurscore=" + idvaleurscore + " ]";
    }
    
}
