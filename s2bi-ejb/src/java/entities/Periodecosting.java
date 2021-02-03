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
    @NamedQuery(name = "Periodecosting.findAll", query = "SELECT p FROM Periodecosting p"),
    @NamedQuery(name = "Periodecosting.findByIdperiodecosting", query = "SELECT p FROM Periodecosting p WHERE p.idperiodecosting = :idperiodecosting"),
    @NamedQuery(name = "Periodecosting.findByLibelle", query = "SELECT p FROM Periodecosting p WHERE p.libelle = :libelle")})
public class Periodecosting implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idperiodecosting;
    @Size(max = 2147483647)
    private String libelle;
    @OneToMany(mappedBy = "idperiodecosting", fetch = FetchType.LAZY)
    private List<Sousperiodecosting> sousperiodecostingList;
    @OneToMany(mappedBy = "idperiodeCosting", fetch = FetchType.LAZY)
    private List<UtilisateurCosting> utilisateurCostingList;

    public Periodecosting() {
    }

    public Periodecosting(Integer idperiodecosting) {
        this.idperiodecosting = idperiodecosting;
    }

    public Integer getIdperiodecosting() {
        return idperiodecosting;
    }

    public void setIdperiodecosting(Integer idperiodecosting) {
        this.idperiodecosting = idperiodecosting;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    @XmlTransient
    public List<Sousperiodecosting> getSousperiodecostingList() {
        return sousperiodecostingList;
    }

    public void setSousperiodecostingList(List<Sousperiodecosting> sousperiodecostingList) {
        this.sousperiodecostingList = sousperiodecostingList;
    }

    @XmlTransient
    public List<UtilisateurCosting> getUtilisateurCostingList() {
        return utilisateurCostingList;
    }

    public void setUtilisateurCostingList(List<UtilisateurCosting> utilisateurCostingList) {
        this.utilisateurCostingList = utilisateurCostingList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idperiodecosting != null ? idperiodecosting.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Periodecosting)) {
            return false;
        }
        Periodecosting other = (Periodecosting) object;
        if ((this.idperiodecosting == null && other.idperiodecosting != null) || (this.idperiodecosting != null && !this.idperiodecosting.equals(other.idperiodecosting))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Periodecosting[ idperiodecosting=" + idperiodecosting + " ]";
    }
    
}
