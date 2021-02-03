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
    @NamedQuery(name = "Financement.findAll", query = "SELECT f FROM Financement f"),
    @NamedQuery(name = "Financement.findByIdfinancement", query = "SELECT f FROM Financement f WHERE f.idfinancement = :idfinancement"),
    @NamedQuery(name = "Financement.findByPourcentage", query = "SELECT f FROM Financement f WHERE f.pourcentage = :pourcentage")})
public class Financement implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idfinancement;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double pourcentage;
    @JoinColumn(name = "idbailleurfond", referencedColumnName = "idbailleurfond")
    @ManyToOne(fetch = FetchType.LAZY)
    private Bailleurfond idbailleurfond;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;
    @JoinColumn(name = "idsous_periode", referencedColumnName = "idsousperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Sousperiodecosting idsousPeriode;
    @JoinColumn(name = "idtypeuniteorganisation", referencedColumnName = "idtypeuniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Typeuniteorganisation idtypeuniteorganisation;

    public Financement() {
    }

    public Financement(Long idfinancement) {
        this.idfinancement = idfinancement;
    }

    public Long getIdfinancement() {
        return idfinancement;
    }

    public void setIdfinancement(Long idfinancement) {
        this.idfinancement = idfinancement;
    }

    public Double getPourcentage() {
        return pourcentage;
    }

    public void setPourcentage(Double pourcentage) {
        this.pourcentage = pourcentage;
    }

    public Bailleurfond getIdbailleurfond() {
        return idbailleurfond;
    }

    public void setIdbailleurfond(Bailleurfond idbailleurfond) {
        this.idbailleurfond = idbailleurfond;
    }

    public Periode getIdperiode() {
        return idperiode;
    }

    public void setIdperiode(Periode idperiode) {
        this.idperiode = idperiode;
    }

    public Sousperiodecosting getIdsousPeriode() {
        return idsousPeriode;
    }

    public void setIdsousPeriode(Sousperiodecosting idsousPeriode) {
        this.idsousPeriode = idsousPeriode;
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
        hash += (idfinancement != null ? idfinancement.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Financement)) {
            return false;
        }
        Financement other = (Financement) object;
        if ((this.idfinancement == null && other.idfinancement != null) || (this.idfinancement != null && !this.idfinancement.equals(other.idfinancement))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Financement[ idfinancement=" + idfinancement + " ]";
    }
    
}
