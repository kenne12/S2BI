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
    @NamedQuery(name = "Financementbudget.findAll", query = "SELECT f FROM Financementbudget f"),
    @NamedQuery(name = "Financementbudget.findByIdfinancementbudget", query = "SELECT f FROM Financementbudget f WHERE f.idfinancementbudget = :idfinancementbudget"),
    @NamedQuery(name = "Financementbudget.findByIdperiode", query = "SELECT f FROM Financementbudget f WHERE f.idperiode = :idperiode"),
    @NamedQuery(name = "Financementbudget.findByBudget", query = "SELECT f FROM Financementbudget f WHERE f.budget = :budget"),
    @NamedQuery(name = "Financementbudget.findByPourcentage", query = "SELECT f FROM Financementbudget f WHERE f.pourcentage = :pourcentage"),
    @NamedQuery(name = "Financementbudget.findByFinancement", query = "SELECT f FROM Financementbudget f WHERE f.financement = :financement")})
public class Financementbudget implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idfinancementbudget;
    private Integer idperiode;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double budget;
    private Double pourcentage;
    private Double financement;
    @JoinColumn(name = "idbailleurfond", referencedColumnName = "idbailleurfond")
    @ManyToOne(fetch = FetchType.LAZY)
    private Bailleurfond idbailleurfond;
    @JoinColumn(name = "idsous_periode", referencedColumnName = "idsousperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Sousperiodecosting idsousPeriode;
    @JoinColumn(name = "idtype_uo", referencedColumnName = "idtypeuniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Typeuniteorganisation idtypeUo;

    public Financementbudget() {
    }

    public Financementbudget(Long idfinancementbudget) {
        this.idfinancementbudget = idfinancementbudget;
    }

    public Long getIdfinancementbudget() {
        return idfinancementbudget;
    }

    public void setIdfinancementbudget(Long idfinancementbudget) {
        this.idfinancementbudget = idfinancementbudget;
    }

    public Integer getIdperiode() {
        return idperiode;
    }

    public void setIdperiode(Integer idperiode) {
        this.idperiode = idperiode;
    }

    public Double getBudget() {
        return budget;
    }

    public void setBudget(Double budget) {
        this.budget = budget;
    }

    public Double getPourcentage() {
        return pourcentage;
    }

    public void setPourcentage(Double pourcentage) {
        this.pourcentage = pourcentage;
    }

    public Double getFinancement() {
        return financement;
    }

    public void setFinancement(Double financement) {
        this.financement = financement;
    }

    public Bailleurfond getIdbailleurfond() {
        return idbailleurfond;
    }

    public void setIdbailleurfond(Bailleurfond idbailleurfond) {
        this.idbailleurfond = idbailleurfond;
    }

    public Sousperiodecosting getIdsousPeriode() {
        return idsousPeriode;
    }

    public void setIdsousPeriode(Sousperiodecosting idsousPeriode) {
        this.idsousPeriode = idsousPeriode;
    }

    public Typeuniteorganisation getIdtypeUo() {
        return idtypeUo;
    }

    public void setIdtypeUo(Typeuniteorganisation idtypeUo) {
        this.idtypeUo = idtypeUo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idfinancementbudget != null ? idfinancementbudget.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Financementbudget)) {
            return false;
        }
        Financementbudget other = (Financementbudget) object;
        if ((this.idfinancementbudget == null && other.idfinancementbudget != null) || (this.idfinancementbudget != null && !this.idfinancementbudget.equals(other.idfinancementbudget))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Financementbudget[ idfinancementbudget=" + idfinancementbudget + " ]";
    }
    
}
