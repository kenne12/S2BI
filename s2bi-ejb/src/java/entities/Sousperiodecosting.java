/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author USER
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Sousperiodecosting.findAll", query = "SELECT s FROM Sousperiodecosting s"),
    @NamedQuery(name = "Sousperiodecosting.findByIdsousperiode", query = "SELECT s FROM Sousperiodecosting s WHERE s.idsousperiode = :idsousperiode"),
    @NamedQuery(name = "Sousperiodecosting.findByPeriodedebut", query = "SELECT s FROM Sousperiodecosting s WHERE s.periodedebut = :periodedebut"),
    @NamedQuery(name = "Sousperiodecosting.findByPeriodefin", query = "SELECT s FROM Sousperiodecosting s WHERE s.periodefin = :periodefin"),
    @NamedQuery(name = "Sousperiodecosting.findByPeriodebase", query = "SELECT s FROM Sousperiodecosting s WHERE s.periodebase = :periodebase"),
    @NamedQuery(name = "Sousperiodecosting.findByNumero", query = "SELECT s FROM Sousperiodecosting s WHERE s.numero = :numero")})
public class Sousperiodecosting implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idsousperiode;
    private Boolean periodedebut;
    private Boolean periodefin;
    private Integer periodebase;
    private Integer numero;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;
    @JoinColumn(name = "idperiodecosting", referencedColumnName = "idperiodecosting")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periodecosting idperiodecosting;
    @OneToMany(mappedBy = "idsousPeriode", fetch = FetchType.LAZY)
    private List<Budget> budgetList;
    @OneToMany(mappedBy = "idsousPeriode", fetch = FetchType.LAZY)
    private List<Financement> financementList;
    @OneToMany(mappedBy = "idsousperiode", fetch = FetchType.LAZY)
    private List<Couverturepopulation> couverturepopulationList;
    @OneToMany(mappedBy = "idsousperiode", fetch = FetchType.LAZY)
    private List<Ciblerealisation> ciblerealisationList;
    @OneToMany(mappedBy = "idsousPeriode", fetch = FetchType.LAZY)
    private List<Financementbudget> financementbudgetList;

    public Sousperiodecosting() {
    }

    public Sousperiodecosting(Integer idsousperiode) {
        this.idsousperiode = idsousperiode;
    }

    public Integer getIdsousperiode() {
        return idsousperiode;
    }

    public void setIdsousperiode(Integer idsousperiode) {
        this.idsousperiode = idsousperiode;
    }

    public Boolean getPeriodedebut() {
        return periodedebut;
    }

    public void setPeriodedebut(Boolean periodedebut) {
        this.periodedebut = periodedebut;
    }

    public Boolean getPeriodefin() {
        return periodefin;
    }

    public void setPeriodefin(Boolean periodefin) {
        this.periodefin = periodefin;
    }

    public Integer getPeriodebase() {
        return periodebase;
    }

    public void setPeriodebase(Integer periodebase) {
        this.periodebase = periodebase;
    }

    public Integer getNumero() {
        return numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    public Periode getIdperiode() {
        return idperiode;
    }

    public void setIdperiode(Periode idperiode) {
        this.idperiode = idperiode;
    }

    public Periodecosting getIdperiodecosting() {
        return idperiodecosting;
    }

    public void setIdperiodecosting(Periodecosting idperiodecosting) {
        this.idperiodecosting = idperiodecosting;
    }

    @XmlTransient
    public List<Budget> getBudgetList() {
        return budgetList;
    }

    public void setBudgetList(List<Budget> budgetList) {
        this.budgetList = budgetList;
    }

    @XmlTransient
    public List<Financement> getFinancementList() {
        return financementList;
    }

    public void setFinancementList(List<Financement> financementList) {
        this.financementList = financementList;
    }

    @XmlTransient
    public List<Couverturepopulation> getCouverturepopulationList() {
        return couverturepopulationList;
    }

    public void setCouverturepopulationList(List<Couverturepopulation> couverturepopulationList) {
        this.couverturepopulationList = couverturepopulationList;
    }

    @XmlTransient
    public List<Ciblerealisation> getCiblerealisationList() {
        return ciblerealisationList;
    }

    public void setCiblerealisationList(List<Ciblerealisation> ciblerealisationList) {
        this.ciblerealisationList = ciblerealisationList;
    }

    @XmlTransient
    public List<Financementbudget> getFinancementbudgetList() {
        return financementbudgetList;
    }

    public void setFinancementbudgetList(List<Financementbudget> financementbudgetList) {
        this.financementbudgetList = financementbudgetList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idsousperiode != null ? idsousperiode.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Sousperiodecosting)) {
            return false;
        }
        Sousperiodecosting other = (Sousperiodecosting) object;
        if ((this.idsousperiode == null && other.idsousperiode != null) || (this.idsousperiode != null && !this.idsousperiode.equals(other.idsousperiode))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Sousperiodecosting[ idsousperiode=" + idsousperiode + " ]";
    }
    
}
