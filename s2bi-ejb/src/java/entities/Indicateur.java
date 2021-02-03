/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
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
    @NamedQuery(name = "Indicateur.findAll", query = "SELECT i FROM Indicateur i"),
    @NamedQuery(name = "Indicateur.findByIdindicateur", query = "SELECT i FROM Indicateur i WHERE i.idindicateur = :idindicateur"),
    @NamedQuery(name = "Indicateur.findByNom", query = "SELECT i FROM Indicateur i WHERE i.nom = :nom"),
    @NamedQuery(name = "Indicateur.findByCode", query = "SELECT i FROM Indicateur i WHERE i.code = :code"),
    @NamedQuery(name = "Indicateur.findByPivot", query = "SELECT i FROM Indicateur i WHERE i.pivot = :pivot"),
    @NamedQuery(name = "Indicateur.findByCiblemensuelle", query = "SELECT i FROM Indicateur i WHERE i.ciblemensuelle = :ciblemensuelle"),
    @NamedQuery(name = "Indicateur.findByDescription", query = "SELECT i FROM Indicateur i WHERE i.description = :description"),
    @NamedQuery(name = "Indicateur.findByCibleAnnuelle", query = "SELECT i FROM Indicateur i WHERE i.cibleAnnuelle = :cibleAnnuelle"),
    @NamedQuery(name = "Indicateur.findByNumerateur", query = "SELECT i FROM Indicateur i WHERE i.numerateur = :numerateur"),
    @NamedQuery(name = "Indicateur.findByDenominateur", query = "SELECT i FROM Indicateur i WHERE i.denominateur = :denominateur"),
    @NamedQuery(name = "Indicateur.findByBaseline", query = "SELECT i FROM Indicateur i WHERE i.baseline = :baseline"),
    @NamedQuery(name = "Indicateur.findByAnneeBaseline", query = "SELECT i FROM Indicateur i WHERE i.anneeBaseline = :anneeBaseline"),
    @NamedQuery(name = "Indicateur.findByCoutunitaire", query = "SELECT i FROM Indicateur i WHERE i.coutunitaire = :coutunitaire")})
public class Indicateur implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idindicateur;
    @Size(max = 254)
    private String nom;
    @Size(max = 254)
    private String code;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double pivot;
    private Double ciblemensuelle;
    @Size(max = 254)
    private String description;
    @Column(name = "cible_annuelle")
    private Double cibleAnnuelle;
    @Size(max = 2147483647)
    private String numerateur;
    @Size(max = 2147483647)
    private String denominateur;
    private Double baseline;
    @Column(name = "annee_baseline")
    private Integer anneeBaseline;
    private Double coutunitaire;
    @ManyToMany(mappedBy = "indicateurList", fetch = FetchType.LAZY)
    private List<Groupindicateur> groupindicateurList;
    @OneToMany(mappedBy = "idindicateur", fetch = FetchType.LAZY)
    private List<Couverture> couvertureList;
    @OneToMany(mappedBy = "idindicateur", fetch = FetchType.LAZY)
    private List<Budget> budgetList;
    @OneToMany(mappedBy = "idindicateur", fetch = FetchType.LAZY)
    private List<Coutunitaireindicateur> coutunitaireindicateurList;
    @OneToMany(mappedBy = "idindicateur", fetch = FetchType.LAZY)
    private List<Cibleannuelle> cibleannuelleList;
    @JoinColumn(name = "idtypeindicateur", referencedColumnName = "idtypeindicateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Typeindicateur idtypeindicateur;
    @OneToMany(mappedBy = "idindicateur", fetch = FetchType.LAZY)
    private List<TypestructureIndicateur> typestructureIndicateurList;
    @OneToMany(mappedBy = "idindicateur", fetch = FetchType.LAZY)
    private List<Ciblerealisation> ciblerealisationList;
    @OneToMany(mappedBy = "idindicateur", fetch = FetchType.LAZY)
    private List<Indicateurpivot> indicateurpivotList;

    public Indicateur() {
    }

    public Indicateur(Integer idindicateur) {
        this.idindicateur = idindicateur;
    }

    public Integer getIdindicateur() {
        return idindicateur;
    }

    public void setIdindicateur(Integer idindicateur) {
        this.idindicateur = idindicateur;
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

    public Double getPivot() {
        return pivot;
    }

    public void setPivot(Double pivot) {
        this.pivot = pivot;
    }

    public Double getCiblemensuelle() {
        return ciblemensuelle;
    }

    public void setCiblemensuelle(Double ciblemensuelle) {
        this.ciblemensuelle = ciblemensuelle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getCibleAnnuelle() {
        return cibleAnnuelle;
    }

    public void setCibleAnnuelle(Double cibleAnnuelle) {
        this.cibleAnnuelle = cibleAnnuelle;
    }

    public String getNumerateur() {
        return numerateur;
    }

    public void setNumerateur(String numerateur) {
        this.numerateur = numerateur;
    }

    public String getDenominateur() {
        return denominateur;
    }

    public void setDenominateur(String denominateur) {
        this.denominateur = denominateur;
    }

    public Double getBaseline() {
        return baseline;
    }

    public void setBaseline(Double baseline) {
        this.baseline = baseline;
    }

    public Integer getAnneeBaseline() {
        return anneeBaseline;
    }

    public void setAnneeBaseline(Integer anneeBaseline) {
        this.anneeBaseline = anneeBaseline;
    }

    public Double getCoutunitaire() {
        return coutunitaire;
    }

    public void setCoutunitaire(Double coutunitaire) {
        this.coutunitaire = coutunitaire;
    }

    @XmlTransient
    public List<Groupindicateur> getGroupindicateurList() {
        return groupindicateurList;
    }

    public void setGroupindicateurList(List<Groupindicateur> groupindicateurList) {
        this.groupindicateurList = groupindicateurList;
    }

    @XmlTransient
    public List<Couverture> getCouvertureList() {
        return couvertureList;
    }

    public void setCouvertureList(List<Couverture> couvertureList) {
        this.couvertureList = couvertureList;
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

    public Typeindicateur getIdtypeindicateur() {
        return idtypeindicateur;
    }

    public void setIdtypeindicateur(Typeindicateur idtypeindicateur) {
        this.idtypeindicateur = idtypeindicateur;
    }

    @XmlTransient
    public List<TypestructureIndicateur> getTypestructureIndicateurList() {
        return typestructureIndicateurList;
    }

    public void setTypestructureIndicateurList(List<TypestructureIndicateur> typestructureIndicateurList) {
        this.typestructureIndicateurList = typestructureIndicateurList;
    }

    @XmlTransient
    public List<Ciblerealisation> getCiblerealisationList() {
        return ciblerealisationList;
    }

    public void setCiblerealisationList(List<Ciblerealisation> ciblerealisationList) {
        this.ciblerealisationList = ciblerealisationList;
    }

    @XmlTransient
    public List<Indicateurpivot> getIndicateurpivotList() {
        return indicateurpivotList;
    }

    public void setIndicateurpivotList(List<Indicateurpivot> indicateurpivotList) {
        this.indicateurpivotList = indicateurpivotList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idindicateur != null ? idindicateur.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Indicateur)) {
            return false;
        }
        Indicateur other = (Indicateur) object;
        if ((this.idindicateur == null && other.idindicateur != null) || (this.idindicateur != null && !this.idindicateur.equals(other.idindicateur))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Indicateur[ idindicateur=" + idindicateur + " ]";
    }
    
}
