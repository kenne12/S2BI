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
    @NamedQuery(name = "Niveaupyramide.findAll", query = "SELECT n FROM Niveaupyramide n"),
    @NamedQuery(name = "Niveaupyramide.findByIdniveaupyramide", query = "SELECT n FROM Niveaupyramide n WHERE n.idniveaupyramide = :idniveaupyramide"),
    @NamedQuery(name = "Niveaupyramide.findByNom", query = "SELECT n FROM Niveaupyramide n WHERE n.nom = :nom"),
    @NamedQuery(name = "Niveaupyramide.findByNumero", query = "SELECT n FROM Niveaupyramide n WHERE n.numero = :numero")})
public class Niveaupyramide implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idniveaupyramide;
    @Size(max = 254)
    private String nom;
    private Integer numero;
    @OneToMany(mappedBy = "idniveaupyramide", fetch = FetchType.LAZY)
    private List<Uniteorganisation> uniteorganisationList;

    public Niveaupyramide() {
    }

    public Niveaupyramide(Integer idniveaupyramide) {
        this.idniveaupyramide = idniveaupyramide;
    }

    public Integer getIdniveaupyramide() {
        return idniveaupyramide;
    }

    public void setIdniveaupyramide(Integer idniveaupyramide) {
        this.idniveaupyramide = idniveaupyramide;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Integer getNumero() {
        return numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    @XmlTransient
    public List<Uniteorganisation> getUniteorganisationList() {
        return uniteorganisationList;
    }

    public void setUniteorganisationList(List<Uniteorganisation> uniteorganisationList) {
        this.uniteorganisationList = uniteorganisationList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idniveaupyramide != null ? idniveaupyramide.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Niveaupyramide)) {
            return false;
        }
        Niveaupyramide other = (Niveaupyramide) object;
        if ((this.idniveaupyramide == null && other.idniveaupyramide != null) || (this.idniveaupyramide != null && !this.idniveaupyramide.equals(other.idniveaupyramide))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Niveaupyramide[ idniveaupyramide=" + idniveaupyramide + " ]";
    }
    
}
