/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author USER
 */
@Entity
@Table(name = "typestructure_indicateur")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TypestructureIndicateur.findAll", query = "SELECT t FROM TypestructureIndicateur t"),
    @NamedQuery(name = "TypestructureIndicateur.findByIdTypestructureIndicateur", query = "SELECT t FROM TypestructureIndicateur t WHERE t.idTypestructureIndicateur = :idTypestructureIndicateur")})
public class TypestructureIndicateur implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_typestructure_indicateur")
    private Long idTypestructureIndicateur;
    @JoinColumn(name = "idindicateur", referencedColumnName = "idindicateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Indicateur idindicateur;
    @JoinColumn(name = "idtypestructure", referencedColumnName = "idtypeuniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Typeuniteorganisation idtypestructure;

    public TypestructureIndicateur() {
    }

    public TypestructureIndicateur(Long idTypestructureIndicateur) {
        this.idTypestructureIndicateur = idTypestructureIndicateur;
    }

    public Long getIdTypestructureIndicateur() {
        return idTypestructureIndicateur;
    }

    public void setIdTypestructureIndicateur(Long idTypestructureIndicateur) {
        this.idTypestructureIndicateur = idTypestructureIndicateur;
    }

    public Indicateur getIdindicateur() {
        return idindicateur;
    }

    public void setIdindicateur(Indicateur idindicateur) {
        this.idindicateur = idindicateur;
    }

    public Typeuniteorganisation getIdtypestructure() {
        return idtypestructure;
    }

    public void setIdtypestructure(Typeuniteorganisation idtypestructure) {
        this.idtypestructure = idtypestructure;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTypestructureIndicateur != null ? idTypestructureIndicateur.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TypestructureIndicateur)) {
            return false;
        }
        TypestructureIndicateur other = (TypestructureIndicateur) object;
        if ((this.idTypestructureIndicateur == null && other.idTypestructureIndicateur != null) || (this.idTypestructureIndicateur != null && !this.idTypestructureIndicateur.equals(other.idTypestructureIndicateur))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.TypestructureIndicateur[ idTypestructureIndicateur=" + idTypestructureIndicateur + " ]";
    }
    
}
