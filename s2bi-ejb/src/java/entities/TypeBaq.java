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
@Table(name = "type_baq")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TypeBaq.findAll", query = "SELECT t FROM TypeBaq t"),
    @NamedQuery(name = "TypeBaq.findByIdTypeBaq", query = "SELECT t FROM TypeBaq t WHERE t.idTypeBaq = :idTypeBaq"),
    @NamedQuery(name = "TypeBaq.findByCode", query = "SELECT t FROM TypeBaq t WHERE t.code = :code"),
    @NamedQuery(name = "TypeBaq.findByNom", query = "SELECT t FROM TypeBaq t WHERE t.nom = :nom")})
public class TypeBaq implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_type_baq")
    private Integer idTypeBaq;
    @Size(max = 30)
    private String code;
    @Size(max = 50)
    private String nom;
    @OneToMany(mappedBy = "idTypeBaq", fetch = FetchType.LAZY)
    private List<Lignebaq> lignebaqList;

    public TypeBaq() {
    }

    public TypeBaq(Integer idTypeBaq) {
        this.idTypeBaq = idTypeBaq;
    }

    public Integer getIdTypeBaq() {
        return idTypeBaq;
    }

    public void setIdTypeBaq(Integer idTypeBaq) {
        this.idTypeBaq = idTypeBaq;
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

    @XmlTransient
    public List<Lignebaq> getLignebaqList() {
        return lignebaqList;
    }

    public void setLignebaqList(List<Lignebaq> lignebaqList) {
        this.lignebaqList = lignebaqList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTypeBaq != null ? idTypeBaq.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TypeBaq)) {
            return false;
        }
        TypeBaq other = (TypeBaq) object;
        if ((this.idTypeBaq == null && other.idTypeBaq != null) || (this.idTypeBaq != null && !this.idTypeBaq.equals(other.idTypeBaq))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.TypeBaq[ idTypeBaq=" + idTypeBaq + " ]";
    }
    
}
