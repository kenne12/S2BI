/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author USER
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Periode.findAll", query = "SELECT p FROM Periode p"),
    @NamedQuery(name = "Periode.findByIdperiode", query = "SELECT p FROM Periode p WHERE p.idperiode = :idperiode"),
    @NamedQuery(name = "Periode.findByNom", query = "SELECT p FROM Periode p WHERE p.nom = :nom"),
    @NamedQuery(name = "Periode.findByCode", query = "SELECT p FROM Periode p WHERE p.code = :code"),
    @NamedQuery(name = "Periode.findByDatedebut", query = "SELECT p FROM Periode p WHERE p.datedebut = :datedebut"),
    @NamedQuery(name = "Periode.findByDatefin", query = "SELECT p FROM Periode p WHERE p.datefin = :datefin"),
    @NamedQuery(name = "Periode.findByIdparent", query = "SELECT p FROM Periode p WHERE p.idparent = :idparent"),
    @NamedQuery(name = "Periode.findByEtat", query = "SELECT p FROM Periode p WHERE p.etat = :etat"),
    @NamedQuery(name = "Periode.findByPeriodeDebut", query = "SELECT p FROM Periode p WHERE p.periodeDebut = :periodeDebut"),
    @NamedQuery(name = "Periode.findByPeriodeFin", query = "SELECT p FROM Periode p WHERE p.periodeFin = :periodeFin")})
public class Periode implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idperiode;
    @Size(max = 254)
    private String nom;
    @Size(max = 254)
    private String code;
    @Temporal(TemporalType.DATE)
    private Date datedebut;
    @Temporal(TemporalType.DATE)
    private Date datefin;
    private Integer idparent;
    private Boolean etat;
    @Column(name = "periode_debut")
    private Boolean periodeDebut;
    @Column(name = "periode_fin")
    private Boolean periodeFin;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Valeurscore> valeurscoreList;
    @JoinColumn(name = "idtype_periode", referencedColumnName = "idtype_periode")
    @ManyToOne(fetch = FetchType.LAZY)
    private TypePeriode idtypePeriode;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Bonusqualite> bonusqualiteList;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<DevisePeriode> devisePeriodeList;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Tauxurbanisation> tauxurbanisationList;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Couverture> couvertureList;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Sousperiodecosting> sousperiodecostingList;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Budget> budgetList;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Coutunitaireindicateur> coutunitaireindicateurList;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Cibleannuelle> cibleannuelleList;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Financement> financementList;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Couverturepopulation> couverturepopulationList;
    @OneToMany(mappedBy = "idperiode", fetch = FetchType.LAZY)
    private List<Ciblerealisation> ciblerealisationList;

    public Periode() {
    }

    public Periode(Integer idperiode) {
        this.idperiode = idperiode;
    }

    public Integer getIdperiode() {
        return idperiode;
    }

    public void setIdperiode(Integer idperiode) {
        this.idperiode = idperiode;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getDatedebut() {
        return datedebut;
    }

    public void setDatedebut(Date datedebut) {
        this.datedebut = datedebut;
    }

    public Date getDatefin() {
        return datefin;
    }

    public void setDatefin(Date datefin) {
        this.datefin = datefin;
    }

    public Integer getIdparent() {
        return idparent;
    }

    public void setIdparent(Integer idparent) {
        this.idparent = idparent;
    }

    public Boolean getEtat() {
        return etat;
    }

    public void setEtat(Boolean etat) {
        this.etat = etat;
    }

    public Boolean getPeriodeDebut() {
        return periodeDebut;
    }

    public void setPeriodeDebut(Boolean periodeDebut) {
        this.periodeDebut = periodeDebut;
    }

    public Boolean getPeriodeFin() {
        return periodeFin;
    }

    public void setPeriodeFin(Boolean periodeFin) {
        this.periodeFin = periodeFin;
    }

    @XmlTransient
    public List<Valeurscore> getValeurscoreList() {
        return valeurscoreList;
    }

    public void setValeurscoreList(List<Valeurscore> valeurscoreList) {
        this.valeurscoreList = valeurscoreList;
    }

    public TypePeriode getIdtypePeriode() {
        return idtypePeriode;
    }

    public void setIdtypePeriode(TypePeriode idtypePeriode) {
        this.idtypePeriode = idtypePeriode;
    }

    @XmlTransient
    public List<Bonusqualite> getBonusqualiteList() {
        return bonusqualiteList;
    }

    public void setBonusqualiteList(List<Bonusqualite> bonusqualiteList) {
        this.bonusqualiteList = bonusqualiteList;
    }

    @XmlTransient
    public List<DevisePeriode> getDevisePeriodeList() {
        return devisePeriodeList;
    }

    public void setDevisePeriodeList(List<DevisePeriode> devisePeriodeList) {
        this.devisePeriodeList = devisePeriodeList;
    }

    @XmlTransient
    public List<Tauxurbanisation> getTauxurbanisationList() {
        return tauxurbanisationList;
    }

    public void setTauxurbanisationList(List<Tauxurbanisation> tauxurbanisationList) {
        this.tauxurbanisationList = tauxurbanisationList;
    }

    @XmlTransient
    public List<Couverture> getCouvertureList() {
        return couvertureList;
    }

    public void setCouvertureList(List<Couverture> couvertureList) {
        this.couvertureList = couvertureList;
    }

    @XmlTransient
    public List<Sousperiodecosting> getSousperiodecostingList() {
        return sousperiodecostingList;
    }

    public void setSousperiodecostingList(List<Sousperiodecosting> sousperiodecostingList) {
        this.sousperiodecostingList = sousperiodecostingList;
    }

    @XmlTransient
    public List<Budget> getBudgetList() {
        return budgetList;
    }

    public void setBudgetList(List<Budget> budgetList) {
        this.budgetList = budgetList;
    }

    @XmlTransient
    public List<Coutunitaireindicateur> getCoutunitaireindicateurList() {
        return coutunitaireindicateurList;
    }

    public void setCoutunitaireindicateurList(List<Coutunitaireindicateur> coutunitaireindicateurList) {
        this.coutunitaireindicateurList = coutunitaireindicateurList;
    }

    @XmlTransient
    public List<Cibleannuelle> getCibleannuelleList() {
        return cibleannuelleList;
    }

    public void setCibleannuelleList(List<Cibleannuelle> cibleannuelleList) {
        this.cibleannuelleList = cibleannuelleList;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idperiode != null ? idperiode.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Periode)) {
            return false;
        }
        Periode other = (Periode) object;
        if ((this.idperiode == null && other.idperiode != null) || (this.idperiode != null && !this.idperiode.equals(other.idperiode))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Periode[ idperiode=" + idperiode + " ]";
    }
    
}
