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
@Table(name = "type_periode")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TypePeriode.findAll", query = "SELECT t FROM TypePeriode t"),
    @NamedQuery(name = "TypePeriode.findByCode", query = "SELECT t FROM TypePeriode t WHERE t.code = :code"),
    @NamedQuery(name = "TypePeriode.findByNom", query = "SELECT t FROM TypePeriode t WHERE t.nom = :nom"),
    @NamedQuery(name = "TypePeriode.findByCoefMultiplicateur", query = "SELECT t FROM TypePeriode t WHERE t.coefMultiplicateur = :coefMultiplicateur"),
    @NamedQuery(name = "TypePeriode.findByIdtypePeriode", query = "SELECT t FROM TypePeriode t WHERE t.idtypePeriode = :idtypePeriode")})
public class TypePeriode implements Serializable {
    private static final long serialVersionUID = 1L;
    @Size(max = 2147483647)
    private String code;
    @Size(max = 2147483647)
    private String nom;
    @Column(name = "coef_multiplicateur")
    private Integer coefMultiplicateur;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idtype_periode")
    private Integer idtypePeriode;
    @OneToMany(mappedBy = "idtypePeriode", fetch = FetchType.LAZY)
    private List<Periode> periodeList;

    public TypePeriode() {
    }

    public TypePeriode(Integer idtypePeriode) {
        this.idtypePeriode = idtypePeriode;
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

    public Integer getCoefMultiplicateur() {
        return coefMultiplicateur;
    }

    public void setCoefMultiplicateur(Integer coefMultiplicateur) {
        this.coefMultiplicateur = coefMultiplicateur;
    }

    public Integer getIdtypePeriode() {
        return idtypePeriode;
    }

    public void setIdtypePeriode(Integer idtypePeriode) {
        this.idtypePeriode = idtypePeriode;
    }

    @XmlTransient
    public List<Periode> getPeriodeList() {
        return periodeList;
    }

    public void setPeriodeList(List<Periode> periodeList) {
        this.periodeList = periodeList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtypePeriode != null ? idtypePeriode.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TypePeriode)) {
            return false;
        }
        TypePeriode other = (TypePeriode) object;
        if ((this.idtypePeriode == null && other.idtypePeriode != null) || (this.idtypePeriode != null && !this.idtypePeriode.equals(other.idtypePeriode))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.TypePeriode[ idtypePeriode=" + idtypePeriode + " ]";
    }
    
}
