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
    @NamedQuery(name = "Bailleurfond.findAll", query = "SELECT b FROM Bailleurfond b"),
    @NamedQuery(name = "Bailleurfond.findByIdbailleurfond", query = "SELECT b FROM Bailleurfond b WHERE b.idbailleurfond = :idbailleurfond"),
    @NamedQuery(name = "Bailleurfond.findByNom", query = "SELECT b FROM Bailleurfond b WHERE b.nom = :nom"),
    @NamedQuery(name = "Bailleurfond.findByCode", query = "SELECT b FROM Bailleurfond b WHERE b.code = :code")})
public class Bailleurfond implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idbailleurfond;
    @Size(max = 254)
    private String nom;
    @Size(max = 254)
    private String code;
    @JoinColumn(name = "idsourcefinancement", referencedColumnName = "idsourcefinancement")
    @ManyToOne(fetch = FetchType.LAZY)
    private Sourcefinancement idsourcefinancement;
    @OneToMany(mappedBy = "idbailleurfond", fetch = FetchType.LAZY)
    private List<Financement> financementList;
    @OneToMany(mappedBy = "idbailleurfond", fetch = FetchType.LAZY)
    private List<Financementbudget> financementbudgetList;

    public Bailleurfond() {
    }

    public Bailleurfond(Integer idbailleurfond) {
        this.idbailleurfond = idbailleurfond;
    }

    public Integer getIdbailleurfond() {
        return idbailleurfond;
    }

    public void setIdbailleurfond(Integer idbailleurfond) {
        this.idbailleurfond = idbailleurfond;
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

    public Sourcefinancement getIdsourcefinancement() {
        return idsourcefinancement;
    }

    public void setIdsourcefinancement(Sourcefinancement idsourcefinancement) {
        this.idsourcefinancement = idsourcefinancement;
    }

    @XmlTransient
    public List<Financement> getFinancementList() {
        return financementList;
    }

    public void setFinancementList(List<Financement> financementList) {
        this.financementList = financementList;
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
        hash += (idbailleurfond != null ? idbailleurfond.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Bailleurfond)) {
            return false;
        }
        Bailleurfond other = (Bailleurfond) object;
        if ((this.idbailleurfond == null && other.idbailleurfond != null) || (this.idbailleurfond != null && !this.idbailleurfond.equals(other.idbailleurfond))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Bailleurfond[ idbailleurfond=" + idbailleurfond + " ]";
    }
    
}
