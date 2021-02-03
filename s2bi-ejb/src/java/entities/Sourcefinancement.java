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
    @NamedQuery(name = "Sourcefinancement.findAll", query = "SELECT s FROM Sourcefinancement s"),
    @NamedQuery(name = "Sourcefinancement.findByIdsourcefinancement", query = "SELECT s FROM Sourcefinancement s WHERE s.idsourcefinancement = :idsourcefinancement"),
    @NamedQuery(name = "Sourcefinancement.findByNom", query = "SELECT s FROM Sourcefinancement s WHERE s.nom = :nom"),
    @NamedQuery(name = "Sourcefinancement.findByCode", query = "SELECT s FROM Sourcefinancement s WHERE s.code = :code")})
public class Sourcefinancement implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idsourcefinancement;
    @Size(max = 254)
    private String nom;
    @Size(max = 254)
    private String code;
    @OneToMany(mappedBy = "idsourcefinancement", fetch = FetchType.LAZY)
    private List<Bailleurfond> bailleurfondList;

    public Sourcefinancement() {
    }

    public Sourcefinancement(Integer idsourcefinancement) {
        this.idsourcefinancement = idsourcefinancement;
    }

    public Integer getIdsourcefinancement() {
        return idsourcefinancement;
    }

    public void setIdsourcefinancement(Integer idsourcefinancement) {
        this.idsourcefinancement = idsourcefinancement;
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
    public List<Bailleurfond> getBailleurfondList() {
        return bailleurfondList;
    }

    public void setBailleurfondList(List<Bailleurfond> bailleurfondList) {
        this.bailleurfondList = bailleurfondList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idsourcefinancement != null ? idsourcefinancement.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Sourcefinancement)) {
            return false;
        }
        Sourcefinancement other = (Sourcefinancement) object;
        if ((this.idsourcefinancement == null && other.idsourcefinancement != null) || (this.idsourcefinancement != null && !this.idsourcefinancement.equals(other.idsourcefinancement))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Sourcefinancement[ idsourcefinancement=" + idsourcefinancement + " ]";
    }
    
}
