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
    @NamedQuery(name = "Typescore.findAll", query = "SELECT t FROM Typescore t"),
    @NamedQuery(name = "Typescore.findByIdtypescore", query = "SELECT t FROM Typescore t WHERE t.idtypescore = :idtypescore"),
    @NamedQuery(name = "Typescore.findByNom", query = "SELECT t FROM Typescore t WHERE t.nom = :nom"),
    @NamedQuery(name = "Typescore.findByPoids", query = "SELECT t FROM Typescore t WHERE t.poids = :poids")})
public class Typescore implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idtypescore;
    @Size(max = 254)
    private String nom;
    private Integer poids;
    @OneToMany(mappedBy = "idtypescore", fetch = FetchType.LAZY)
    private List<Valeurscore> valeurscoreList;

    public Typescore() {
    }

    public Typescore(Integer idtypescore) {
        this.idtypescore = idtypescore;
    }

    public Integer getIdtypescore() {
        return idtypescore;
    }

    public void setIdtypescore(Integer idtypescore) {
        this.idtypescore = idtypescore;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Integer getPoids() {
        return poids;
    }

    public void setPoids(Integer poids) {
        this.poids = poids;
    }

    @XmlTransient
    public List<Valeurscore> getValeurscoreList() {
        return valeurscoreList;
    }

    public void setValeurscoreList(List<Valeurscore> valeurscoreList) {
        this.valeurscoreList = valeurscoreList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtypescore != null ? idtypescore.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Typescore)) {
            return false;
        }
        Typescore other = (Typescore) object;
        if ((this.idtypescore == null && other.idtypescore != null) || (this.idtypescore != null && !this.idtypescore.equals(other.idtypescore))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Typescore[ idtypescore=" + idtypescore + " ]";
    }
    
}
