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
    @NamedQuery(name = "Budget.findAll", query = "SELECT b FROM Budget b"),
    @NamedQuery(name = "Budget.findByIdbudget", query = "SELECT b FROM Budget b WHERE b.idbudget = :idbudget"),
    @NamedQuery(name = "Budget.findByCibleideale", query = "SELECT b FROM Budget b WHERE b.cibleideale = :cibleideale"),
    @NamedQuery(name = "Budget.findByCibleprogramme", query = "SELECT b FROM Budget b WHERE b.cibleprogramme = :cibleprogramme"),
    @NamedQuery(name = "Budget.findByCoutunitaire", query = "SELECT b FROM Budget b WHERE b.coutunitaire = :coutunitaire"),
    @NamedQuery(name = "Budget.findByTotal", query = "SELECT b FROM Budget b WHERE b.total = :total"),
    @NamedQuery(name = "Budget.findByBonusequite", query = "SELECT b FROM Budget b WHERE b.bonusequite = :bonusequite"),
    @NamedQuery(name = "Budget.findByScoremoyen", query = "SELECT b FROM Budget b WHERE b.scoremoyen = :scoremoyen"),
    @NamedQuery(name = "Budget.findByBonusqualite", query = "SELECT b FROM Budget b WHERE b.bonusqualite = :bonusqualite"),
    @NamedQuery(name = "Budget.findByTotal1", query = "SELECT b FROM Budget b WHERE b.total1 = :total1"),
    @NamedQuery(name = "Budget.findByTotal2", query = "SELECT b FROM Budget b WHERE b.total2 = :total2"),
    @NamedQuery(name = "Budget.findByBaq", query = "SELECT b FROM Budget b WHERE b.baq = :baq")})
public class Budget implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idbudget;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double cibleideale;
    private Double cibleprogramme;
    private Double coutunitaire;
    private Double total;
    private Double bonusequite;
    private Double scoremoyen;
    private Double bonusqualite;
    private Double total1;
    private Double total2;
    private Double baq;
    @JoinColumn(name = "idindicateur", referencedColumnName = "idindicateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Indicateur idindicateur;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;
    @JoinColumn(name = "idsous_periode", referencedColumnName = "idsousperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Sousperiodecosting idsousPeriode;
    @JoinColumn(name = "iduniteorganisation", referencedColumnName = "iduniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Uniteorganisation iduniteorganisation;

    public Budget() {
    }

    public Budget(Long idbudget) {
        this.idbudget = idbudget;
    }

    public Long getIdbudget() {
        return idbudget;
    }

    public void setIdbudget(Long idbudget) {
        this.idbudget = idbudget;
    }

    public Double getCibleideale() {
        return cibleideale;
    }

    public void setCibleideale(Double cibleideale) {
        this.cibleideale = cibleideale;
    }

    public Double getCibleprogramme() {
        return cibleprogramme;
    }

    public void setCibleprogramme(Double cibleprogramme) {
        this.cibleprogramme = cibleprogramme;
    }

    public Double getCoutunitaire() {
        return coutunitaire;
    }

    public void setCoutunitaire(Double coutunitaire) {
        this.coutunitaire = coutunitaire;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getBonusequite() {
        return bonusequite;
    }

    public void setBonusequite(Double bonusequite) {
        this.bonusequite = bonusequite;
    }

    public Double getScoremoyen() {
        return scoremoyen;
    }

    public void setScoremoyen(Double scoremoyen) {
        this.scoremoyen = scoremoyen;
    }

    public Double getBonusqualite() {
        return bonusqualite;
    }

    public void setBonusqualite(Double bonusqualite) {
        this.bonusqualite = bonusqualite;
    }

    public Double getTotal1() {
        return total1;
    }

    public void setTotal1(Double total1) {
        this.total1 = total1;
    }

    public Double getTotal2() {
        return total2;
    }

    public void setTotal2(Double total2) {
        this.total2 = total2;
    }

    public Double getBaq() {
        return baq;
    }

    public void setBaq(Double baq) {
        this.baq = baq;
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

    public Sousperiodecosting getIdsousPeriode() {
        return idsousPeriode;
    }

    public void setIdsousPeriode(Sousperiodecosting idsousPeriode) {
        this.idsousPeriode = idsousPeriode;
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
        hash += (idbudget != null ? idbudget.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Budget)) {
            return false;
        }
        Budget other = (Budget) object;
        if ((this.idbudget == null && other.idbudget != null) || (this.idbudget != null && !this.idbudget.equals(other.idbudget))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Budget[ idbudget=" + idbudget + " ]";
    }
    
}
