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
    @NamedQuery(name = "Typeindicateur.findAll", query = "SELECT t FROM Typeindicateur t"),
    @NamedQuery(name = "Typeindicateur.findByIdtypeindicateur", query = "SELECT t FROM Typeindicateur t WHERE t.idtypeindicateur = :idtypeindicateur"),
    @NamedQuery(name = "Typeindicateur.findByNom", query = "SELECT t FROM Typeindicateur t WHERE t.nom = :nom"),
    @NamedQuery(name = "Typeindicateur.findByCode", query = "SELECT t FROM Typeindicateur t WHERE t.code = :code")})
public class Typeindicateur implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idtypeindicateur;
    @Size(max = 254)
    private String nom;
    @Size(max = 2147483647)
    private String code;
    @OneToMany(mappedBy = "idtypeindicateur", fetch = FetchType.LAZY)
    private List<Indicateur> indicateurList;
    @OneToMany(mappedBy = "idtypeindicateur", fetch = FetchType.LAZY)
    private List<Indicateurpivot> indicateurpivotList;

    public Typeindicateur() {
    }

    public Typeindicateur(Integer idtypeindicateur) {
        this.idtypeindicateur = idtypeindicateur;
    }

    public Integer getIdtypeindicateur() {
        return idtypeindicateur;
    }

    public void setIdtypeindicateur(Integer idtypeindicateur) {
        this.idtypeindicateur = idtypeindicateur;
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
    public List<Indicateur> getIndicateurList() {
        return indicateurList;
    }

    public void setIndicateurList(List<Indicateur> indicateurList) {
        this.indicateurList = indicateurList;
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
        hash += (idtypeindicateur != null ? idtypeindicateur.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Typeindicateur)) {
            return false;
        }
        Typeindicateur other = (Typeindicateur) object;
        if ((this.idtypeindicateur == null && other.idtypeindicateur != null) || (this.idtypeindicateur != null && !this.idtypeindicateur.equals(other.idtypeindicateur))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Typeindicateur[ idtypeindicateur=" + idtypeindicateur + " ]";
    }
    
}
