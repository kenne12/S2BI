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
    @NamedQuery(name = "Uniteorganisation.findAll", query = "SELECT u FROM Uniteorganisation u"),
    @NamedQuery(name = "Uniteorganisation.findByIduniteorganisation", query = "SELECT u FROM Uniteorganisation u WHERE u.iduniteorganisation = :iduniteorganisation"),
    @NamedQuery(name = "Uniteorganisation.findByNom", query = "SELECT u FROM Uniteorganisation u WHERE u.nom = :nom"),
    @NamedQuery(name = "Uniteorganisation.findByCode", query = "SELECT u FROM Uniteorganisation u WHERE u.code = :code"),
    @NamedQuery(name = "Uniteorganisation.findByIdparent", query = "SELECT u FROM Uniteorganisation u WHERE u.idparent = :idparent"),
    @NamedQuery(name = "Uniteorganisation.findByCostingfosa", query = "SELECT u FROM Uniteorganisation u WHERE u.costingfosa = :costingfosa")})
public class Uniteorganisation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer iduniteorganisation;
    @Size(max = 254)
    private String nom;
    @Size(max = 254)
    private String code;
    private Integer idparent;
    private Boolean costingfosa;
    @OneToMany(mappedBy = "iduniteorganisation", fetch = FetchType.LAZY)
    private List<Valeurscore> valeurscoreList;
    @OneToMany(mappedBy = "iduniteorganisation", fetch = FetchType.LAZY)
    private List<Tauxurbanisation> tauxurbanisationList;
    @OneToMany(mappedBy = "iduniteorganisation", fetch = FetchType.LAZY)
    private List<Couverture> couvertureList;
    @OneToMany(mappedBy = "iduniteorganisation", fetch = FetchType.LAZY)
    private List<Budget> budgetList;
    @JoinColumn(name = "idniveaupyramide", referencedColumnName = "idniveaupyramide")
    @ManyToOne(fetch = FetchType.LAZY)
    private Niveaupyramide idniveaupyramide;
    @JoinColumn(name = "idtypeuniteorganisation", referencedColumnName = "idtypeuniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Typeuniteorganisation idtypeuniteorganisation;
    @OneToMany(mappedBy = "iduniteorganisation", fetch = FetchType.LAZY)
    private List<Cibleannuelle> cibleannuelleList;
    @OneToMany(mappedBy = "iduniteorganisation", fetch = FetchType.LAZY)
    private List<Couverturepopulation> couverturepopulationList;
    @OneToMany(mappedBy = "iduniteorganisation", fetch = FetchType.LAZY)
    private List<Ciblerealisation> ciblerealisationList;

    public Uniteorganisation() {
    }

    public Uniteorganisation(Integer iduniteorganisation) {
        this.iduniteorganisation = iduniteorganisation;
    }

    public Integer getIduniteorganisation() {
        return iduniteorganisation;
    }

    public void setIduniteorganisation(Integer iduniteorganisation) {
        this.iduniteorganisation = iduniteorganisation;
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

    public Integer getIdparent() {
        return idparent;
    }

    public void setIdparent(Integer idparent) {
        this.idparent = idparent;
    }

    public Boolean getCostingfosa() {
        return costingfosa;
    }

    public void setCostingfosa(Boolean costingfosa) {
        this.costingfosa = costingfosa;
    }

    @XmlTransient
    public List<Valeurscore> getValeurscoreList() {
        return valeurscoreList;
    }

    public void setValeurscoreList(List<Valeurscore> valeurscoreList) {
        this.valeurscoreList = valeurscoreList;
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
    public List<Budget> getBudgetList() {
        return budgetList;
    }

    public void setBudgetList(List<Budget> budgetList) {
        this.budgetList = budgetList;
    }

    public Niveaupyramide getIdniveaupyramide() {
        return idniveaupyramide;
    }

    public void setIdniveaupyramide(Niveaupyramide idniveaupyramide) {
        this.idniveaupyramide = idniveaupyramide;
    }

    public Typeuniteorganisation getIdtypeuniteorganisation() {
        return idtypeuniteorganisation;
    }

    public void setIdtypeuniteorganisation(Typeuniteorganisation idtypeuniteorganisation) {
        this.idtypeuniteorganisation = idtypeuniteorganisation;
    }

    @XmlTransient
    public List<Cibleannuelle> getCibleannuelleList() {
        return cibleannuelleList;
    }

    public void setCibleannuelleList(List<Cibleannuelle> cibleannuelleList) {
        this.cibleannuelleList = cibleannuelleList;
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
        hash += (iduniteorganisation != null ? iduniteorganisation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Uniteorganisation)) {
            return false;
        }
        Uniteorganisation other = (Uniteorganisation) object;
        if ((this.iduniteorganisation == null && other.iduniteorganisation != null) || (this.iduniteorganisation != null && !this.iduniteorganisation.equals(other.iduniteorganisation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Uniteorganisation[ iduniteorganisation=" + iduniteorganisation + " ]";
    }
    
}
