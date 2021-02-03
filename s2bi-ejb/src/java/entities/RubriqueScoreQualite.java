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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author USER
 */
@Entity
@Table(name = "rubrique_score_qualite")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RubriqueScoreQualite.findAll", query = "SELECT r FROM RubriqueScoreQualite r"),
    @NamedQuery(name = "RubriqueScoreQualite.findByIdRubriqueScoreQualite", query = "SELECT r FROM RubriqueScoreQualite r WHERE r.idRubriqueScoreQualite = :idRubriqueScoreQualite"),
    @NamedQuery(name = "RubriqueScoreQualite.findByCode", query = "SELECT r FROM RubriqueScoreQualite r WHERE r.code = :code"),
    @NamedQuery(name = "RubriqueScoreQualite.findByNom", query = "SELECT r FROM RubriqueScoreQualite r WHERE r.nom = :nom"),
    @NamedQuery(name = "RubriqueScoreQualite.findByPoids", query = "SELECT r FROM RubriqueScoreQualite r WHERE r.poids = :poids")})
public class RubriqueScoreQualite implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_rubrique_score_qualite")
    private Integer idRubriqueScoreQualite;
    @Size(max = 2147483647)
    private String code;
    @Size(max = 2147483647)
    private String nom;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double poids;
    @OneToMany(mappedBy = "idrubriqueScore", fetch = FetchType.LAZY)
    private List<LigneScoreEquite> ligneScoreEquiteList;

    public RubriqueScoreQualite() {
    }

    public RubriqueScoreQualite(Integer idRubriqueScoreQualite) {
        this.idRubriqueScoreQualite = idRubriqueScoreQualite;
    }

    public Integer getIdRubriqueScoreQualite() {
        return idRubriqueScoreQualite;
    }

    public void setIdRubriqueScoreQualite(Integer idRubriqueScoreQualite) {
        this.idRubriqueScoreQualite = idRubriqueScoreQualite;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Double getPoids() {
        return poids;
    }

    public void setPoids(Double poids) {
        this.poids = poids;
    }

    @XmlTransient
    public List<LigneScoreEquite> getLigneScoreEquiteList() {
        return ligneScoreEquiteList;
    }

    public void setLigneScoreEquiteList(List<LigneScoreEquite> ligneScoreEquiteList) {
        this.ligneScoreEquiteList = ligneScoreEquiteList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRubriqueScoreQualite != null ? idRubriqueScoreQualite.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RubriqueScoreQualite)) {
            return false;
        }
        RubriqueScoreQualite other = (RubriqueScoreQualite) object;
        if ((this.idRubriqueScoreQualite == null && other.idRubriqueScoreQualite != null) || (this.idRubriqueScoreQualite != null && !this.idRubriqueScoreQualite.equals(other.idRubriqueScoreQualite))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.RubriqueScoreQualite[ idRubriqueScoreQualite=" + idRubriqueScoreQualite + " ]";
    }
    
}
