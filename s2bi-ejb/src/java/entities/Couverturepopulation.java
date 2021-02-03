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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author USER
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Couverturepopulation.findAll", query = "SELECT c FROM Couverturepopulation c"),
    @NamedQuery(name = "Couverturepopulation.findByIdcouverturepopulation", query = "SELECT c FROM Couverturepopulation c WHERE c.idcouverturepopulation = :idcouverturepopulation"),
    @NamedQuery(name = "Couverturepopulation.findByValeur", query = "SELECT c FROM Couverturepopulation c WHERE c.valeur = :valeur"),
    @NamedQuery(name = "Couverturepopulation.findByPourcentage", query = "SELECT c FROM Couverturepopulation c WHERE c.pourcentage = :pourcentage"),
    @NamedQuery(name = "Couverturepopulation.findByValDebutScoreE", query = "SELECT c FROM Couverturepopulation c WHERE c.valDebutScoreE = :valDebutScoreE"),
    @NamedQuery(name = "Couverturepopulation.findByValFinScoreE", query = "SELECT c FROM Couverturepopulation c WHERE c.valFinScoreE = :valFinScoreE"),
    @NamedQuery(name = "Couverturepopulation.findByValScoreEquite", query = "SELECT c FROM Couverturepopulation c WHERE c.valScoreEquite = :valScoreEquite"),
    @NamedQuery(name = "Couverturepopulation.findByPasScoreEquite", query = "SELECT c FROM Couverturepopulation c WHERE c.pasScoreEquite = :pasScoreEquite"),
    @NamedQuery(name = "Couverturepopulation.findByMajValDebut", query = "SELECT c FROM Couverturepopulation c WHERE c.majValDebut = :majValDebut"),
    @NamedQuery(name = "Couverturepopulation.findByMajValFin", query = "SELECT c FROM Couverturepopulation c WHERE c.majValFin = :majValFin"),
    @NamedQuery(name = "Couverturepopulation.findByMajoration", query = "SELECT c FROM Couverturepopulation c WHERE c.majoration = :majoration"),
    @NamedQuery(name = "Couverturepopulation.findByPasMajoration", query = "SELECT c FROM Couverturepopulation c WHERE c.pasMajoration = :pasMajoration"),
    @NamedQuery(name = "Couverturepopulation.findByBaq", query = "SELECT c FROM Couverturepopulation c WHERE c.baq = :baq"),
    @NamedQuery(name = "Couverturepopulation.findByValScoreQualite", query = "SELECT c FROM Couverturepopulation c WHERE c.valScoreQualite = :valScoreQualite")})
public class Couverturepopulation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idcouverturepopulation;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double valeur;
    private Double pourcentage;
    @Column(name = "val_debut_score_e")
    private Double valDebutScoreE;
    @Column(name = "val_fin_score_e")
    private Double valFinScoreE;
    @Column(name = "val_score_equite")
    private Double valScoreEquite;
    @Column(name = "pas_score_equite")
    private Double pasScoreEquite;
    @Column(name = "maj_val_debut")
    private Double majValDebut;
    @Column(name = "maj_val_fin")
    private Double majValFin;
    private Double majoration;
    @Column(name = "pas_majoration")
    private Double pasMajoration;
    private Double baq;
    @Column(name = "val_score_qualite")
    private Double valScoreQualite;
    @OneToMany(mappedBy = "idcouverture", fetch = FetchType.LAZY)
    private List<LigneScoreEquite> ligneScoreEquiteList;
    @OneToMany(mappedBy = "idcouverture", fetch = FetchType.LAZY)
    private List<Lignebaq> lignebaqList;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;
    @JoinColumn(name = "idsousperiode", referencedColumnName = "idsousperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Sousperiodecosting idsousperiode;
    @JoinColumn(name = "iduniteorganisation", referencedColumnName = "iduniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Uniteorganisation iduniteorganisation;

    public Couverturepopulation() {
    }

    public Couverturepopulation(Long idcouverturepopulation) {
        this.idcouverturepopulation = idcouverturepopulation;
    }

    public Long getIdcouverturepopulation() {
        return idcouverturepopulation;
    }

    public void setIdcouverturepopulation(Long idcouverturepopulation) {
        this.idcouverturepopulation = idcouverturepopulation;
    }

    public Double getValeur() {
        return valeur;
    }

    public void setValeur(Double valeur) {
        this.valeur = valeur;
    }

    public Double getPourcentage() {
        return pourcentage;
    }

    public void setPourcentage(Double pourcentage) {
        this.pourcentage = pourcentage;
    }

    public Double getValDebutScoreE() {
        return valDebutScoreE;
    }

    public void setValDebutScoreE(Double valDebutScoreE) {
        this.valDebutScoreE = valDebutScoreE;
    }

    public Double getValFinScoreE() {
        return valFinScoreE;
    }

    public void setValFinScoreE(Double valFinScoreE) {
        this.valFinScoreE = valFinScoreE;
    }

    public Double getValScoreEquite() {
        return valScoreEquite;
    }

    public void setValScoreEquite(Double valScoreEquite) {
        this.valScoreEquite = valScoreEquite;
    }

    public Double getPasScoreEquite() {
        return pasScoreEquite;
    }

    public void setPasScoreEquite(Double pasScoreEquite) {
        this.pasScoreEquite = pasScoreEquite;
    }

    public Double getMajValDebut() {
        return majValDebut;
    }

    public void setMajValDebut(Double majValDebut) {
        this.majValDebut = majValDebut;
    }

    public Double getMajValFin() {
        return majValFin;
    }

    public void setMajValFin(Double majValFin) {
        this.majValFin = majValFin;
    }

    public Double getMajoration() {
        return majoration;
    }

    public void setMajoration(Double majoration) {
        this.majoration = majoration;
    }

    public Double getPasMajoration() {
        return pasMajoration;
    }

    public void setPasMajoration(Double pasMajoration) {
        this.pasMajoration = pasMajoration;
    }

    public Double getBaq() {
        return baq;
    }

    public void setBaq(Double baq) {
        this.baq = baq;
    }

    public Double getValScoreQualite() {
        return valScoreQualite;
    }

    public void setValScoreQualite(Double valScoreQualite) {
        this.valScoreQualite = valScoreQualite;
    }

    @XmlTransient
    public List<LigneScoreEquite> getLigneScoreEquiteList() {
        return ligneScoreEquiteList;
    }

    public void setLigneScoreEquiteList(List<LigneScoreEquite> ligneScoreEquiteList) {
        this.ligneScoreEquiteList = ligneScoreEquiteList;
    }

    @XmlTransient
    public List<Lignebaq> getLignebaqList() {
        return lignebaqList;
    }

    public void setLignebaqList(List<Lignebaq> lignebaqList) {
        this.lignebaqList = lignebaqList;
    }

    public Periode getIdperiode() {
        return idperiode;
    }

    public void setIdperiode(Periode idperiode) {
        this.idperiode = idperiode;
    }

    public Sousperiodecosting getIdsousperiode() {
        return idsousperiode;
    }

    public void setIdsousperiode(Sousperiodecosting idsousperiode) {
        this.idsousperiode = idsousperiode;
    }

    public Uniteorganisation getIduniteorganisation() {
        return iduniteorganisation;
    }

    public void setIduniteorganisation(Uniteorganisation iduniteorganisation) {
        this.iduniteorganisation = iduniteorganisation;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcouverturepopulation != null ? idcouverturepopulation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Couverturepopulation)) {
            return false;
        }
        Couverturepopulation other = (Couverturepopulation) object;
        if ((this.idcouverturepopulation == null && other.idcouverturepopulation != null) || (this.idcouverturepopulation != null && !this.idcouverturepopulation.equals(other.idcouverturepopulation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Couverturepopulation[ idcouverturepopulation=" + idcouverturepopulation + " ]";
    }
    
}
