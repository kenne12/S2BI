/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.math.BigInteger;
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
    @NamedQuery(name = "Bonusqualite.findAll", query = "SELECT b FROM Bonusqualite b"),
    @NamedQuery(name = "Bonusqualite.findByIdbonusqualite", query = "SELECT b FROM Bonusqualite b WHERE b.idbonusqualite = :idbonusqualite"),
    @NamedQuery(name = "Bonusqualite.findByTaux", query = "SELECT b FROM Bonusqualite b WHERE b.taux = :taux")})
public class Bonusqualite implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idbonusqualite;
    private BigInteger taux;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;
    @JoinColumn(name = "idtypeuniteorganisation", referencedColumnName = "idtypeuniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Typeuniteorganisation idtypeuniteorganisation;

    public Bonusqualite() {
    }

    public Bonusqualite(Integer idbonusqualite) {
        this.idbonusqualite = idbonusqualite;
    }

    public Integer getIdbonusqualite() {
        return idbonusqualite;
    }

    public void setIdbonusqualite(Integer idbonusqualite) {
        this.idbonusqualite = idbonusqualite;
    }

    public BigInteger getTaux() {
        return taux;
    }

    public void setTaux(BigInteger taux) {
        this.taux = taux;
    }

    public Periode getIdperiode() {
        return idperiode;
    }

    public void setIdperiode(Periode idperiode) {
        this.idperiode = idperiode;
    }

    public Typeuniteorganisation getIdtypeuniteorganisation() {
        return idtypeuniteorganisation;
    }

    public void setIdtypeuniteorganisation(Typeuniteorganisation idtypeuniteorganisation) {
        this.idtypeuniteorganisation = idtypeuniteorganisation;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idbonusqualite != null ? idbonusqualite.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Bonusqualite)) {
            return false;
        }
        Bonusqualite other = (Bonusqualite) object;
        if ((this.idbonusqualite == null && other.idbonusqualite != null) || (this.idbonusqualite != null && !this.idbonusqualite.equals(other.idbonusqualite))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Bonusqualite[ idbonusqualite=" + idbonusqualite + " ]";
    }
    
}
