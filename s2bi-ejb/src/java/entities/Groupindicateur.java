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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
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
    @NamedQuery(name = "Groupindicateur.findAll", query = "SELECT g FROM Groupindicateur g"),
    @NamedQuery(name = "Groupindicateur.findByIdgroupindicateur", query = "SELECT g FROM Groupindicateur g WHERE g.idgroupindicateur = :idgroupindicateur"),
    @NamedQuery(name = "Groupindicateur.findByNom", query = "SELECT g FROM Groupindicateur g WHERE g.nom = :nom"),
    @NamedQuery(name = "Groupindicateur.findByCode", query = "SELECT g FROM Groupindicateur g WHERE g.code = :code")})
public class Groupindicateur implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idgroupindicateur;
    @Size(max = 254)
    private String nom;
    @Size(max = 2147483647)
    private String code;
    @JoinTable(name = "indicateurgroupeindicateur", joinColumns = {
        @JoinColumn(name = "idgroupindicateur", referencedColumnName = "idgroupindicateur")}, inverseJoinColumns = {
        @JoinColumn(name = "idindicateur", referencedColumnName = "idindicateur")})
    @ManyToMany(fetch = FetchType.LAZY)
    private List<Indicateur> indicateurList;

    public Groupindicateur() {
    }

    public Groupindicateur(Integer idgroupindicateur) {
        this.idgroupindicateur = idgroupindicateur;
    }

    public Integer getIdgroupindicateur() {
        return idgroupindicateur;
    }

    public void setIdgroupindicateur(Integer idgroupindicateur) {
        this.idgroupindicateur = idgroupindicateur;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idgroupindicateur != null ? idgroupindicateur.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Groupindicateur)) {
            return false;
        }
        Groupindicateur other = (Groupindicateur) object;
        if ((this.idgroupindicateur == null && other.idgroupindicateur != null) || (this.idgroupindicateur != null && !this.idgroupindicateur.equals(other.idgroupindicateur))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Groupindicateur[ idgroupindicateur=" + idgroupindicateur + " ]";
    }
    
}
