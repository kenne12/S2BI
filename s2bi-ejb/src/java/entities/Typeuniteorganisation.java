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
    @NamedQuery(name = "Typeuniteorganisation.findAll", query = "SELECT t FROM Typeuniteorganisation t"),
    @NamedQuery(name = "Typeuniteorganisation.findByIdtypeuniteorganisation", query = "SELECT t FROM Typeuniteorganisation t WHERE t.idtypeuniteorganisation = :idtypeuniteorganisation"),
    @NamedQuery(name = "Typeuniteorganisation.findByNom", query = "SELECT t FROM Typeuniteorganisation t WHERE t.nom = :nom"),
    @NamedQuery(name = "Typeuniteorganisation.findByCode", query = "SELECT t FROM Typeuniteorganisation t WHERE t.code = :code")})
public class Typeuniteorganisation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idtypeuniteorganisation;
    @Size(max = 254)
    private String nom;
    @Size(max = 254)
    private String code;
    @OneToMany(mappedBy = "idtypeuniteorganisation", fetch = FetchType.LAZY)
    private List<Bonusqualite> bonusqualiteList;
    @OneToMany(mappedBy = "idtypeuniteorganisation", fetch = FetchType.LAZY)
    private List<Uniteorganisation> uniteorganisationList;
    @OneToMany(mappedBy = "idtypeuniteorganisation", fetch = FetchType.LAZY)
    private List<Financement> financementList;
    @OneToMany(mappedBy = "idtypestructure", fetch = FetchType.LAZY)
    private List<TypestructureIndicateur> typestructureIndicateurList;
    @OneToMany(mappedBy = "idtypeUo", fetch = FetchType.LAZY)
    private List<Financementbudget> financementbudgetList;

    public Typeuniteorganisation() {
    }

    public Typeuniteorganisation(Integer idtypeuniteorganisation) {
        this.idtypeuniteorganisation = idtypeuniteorganisation;
    }

    public Integer getIdtypeuniteorganisation() {
        return idtypeuniteorganisation;
    }

    public void setIdtypeuniteorganisation(Integer idtypeuniteorganisation) {
        this.idtypeuniteorganisation = idtypeuniteorganisation;
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

    @XmlTransient
    public List<Bonusqualite> getBonusqualiteList() {
        return bonusqualiteList;
    }

    public void setBonusqualiteList(List<Bonusqualite> bonusqualiteList) {
        this.bonusqualiteList = bonusqualiteList;
    }

    @XmlTransient
    public List<Uniteorganisation> getUniteorganisationList() {
        return uniteorganisationList;
    }

    public void setUniteorganisationList(List<Uniteorganisation> uniteorganisationList) {
        this.uniteorganisationList = uniteorganisationList;
    }

    @XmlTransient
    public List<Financement> getFinancementList() {
        return financementList;
    }

    public void setFinancementList(List<Financement> financementList) {
        this.financementList = financementList;
    }

    @XmlTransient
    public List<TypestructureIndicateur> getTypestructureIndicateurList() {
        return typestructureIndicateurList;
    }

    public void setTypestructureIndicateurList(List<TypestructureIndicateur> typestructureIndicateurList) {
        this.typestructureIndicateurList = typestructureIndicateurList;
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
        hash += (idtypeuniteorganisation != null ? idtypeuniteorganisation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Typeuniteorganisation)) {
            return false;
        }
        Typeuniteorganisation other = (Typeuniteorganisation) object;
        if ((this.idtypeuniteorganisation == null && other.idtypeuniteorganisation != null) || (this.idtypeuniteorganisation != null && !this.idtypeuniteorganisation.equals(other.idtypeuniteorganisation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Typeuniteorganisation[ idtypeuniteorganisation=" + idtypeuniteorganisation + " ]";
    }
    
}
