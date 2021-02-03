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
    @NamedQuery(name = "Devise.findAll", query = "SELECT d FROM Devise d"),
    @NamedQuery(name = "Devise.findByIddevise", query = "SELECT d FROM Devise d WHERE d.iddevise = :iddevise"),
    @NamedQuery(name = "Devise.findByNom", query = "SELECT d FROM Devise d WHERE d.nom = :nom"),
    @NamedQuery(name = "Devise.findByCoutUnitaireDefault", query = "SELECT d FROM Devise d WHERE d.coutUnitaireDefault = :coutUnitaireDefault"),
    @NamedQuery(name = "Devise.findByCode", query = "SELECT d FROM Devise d WHERE d.code = :code"),
    @NamedQuery(name = "Devise.findByDefaultM", query = "SELECT d FROM Devise d WHERE d.defaultM = :defaultM")})
public class Devise implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer iddevise;
    @Size(max = 2147483647)
    private String nom;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "cout_unitaire_default")
    private Double coutUnitaireDefault;
    @Size(max = 30)
    private String code;
    @Column(name = "default_m")
    private Boolean defaultM;
    @OneToMany(mappedBy = "iddevise", fetch = FetchType.LAZY)
    private List<DevisePeriode> devisePeriodeList;

    public Devise() {
    }

    public Devise(Integer iddevise) {
        this.iddevise = iddevise;
    }

    public Integer getIddevise() {
        return iddevise;
    }

    public void setIddevise(Integer iddevise) {
        this.iddevise = iddevise;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Double getCoutUnitaireDefault() {
        return coutUnitaireDefault;
    }

    public void setCoutUnitaireDefault(Double coutUnitaireDefault) {
        this.coutUnitaireDefault = coutUnitaireDefault;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Boolean getDefaultM() {
        return defaultM;
    }

    public void setDefaultM(Boolean defaultM) {
        this.defaultM = defaultM;
    }

    @XmlTransient
    public List<DevisePeriode> getDevisePeriodeList() {
        return devisePeriodeList;
    }

    public void setDevisePeriodeList(List<DevisePeriode> devisePeriodeList) {
        this.devisePeriodeList = devisePeriodeList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iddevise != null ? iddevise.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Devise)) {
            return false;
        }
        Devise other = (Devise) object;
        if ((this.iddevise == null && other.iddevise != null) || (this.iddevise != null && !this.iddevise.equals(other.iddevise))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Devise[ iddevise=" + iddevise + " ]";
    }
    
}
