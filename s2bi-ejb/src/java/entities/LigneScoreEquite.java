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
@Table(name = "ligne_score_equite")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LigneScoreEquite.findAll", query = "SELECT l FROM LigneScoreEquite l"),
    @NamedQuery(name = "LigneScoreEquite.findByIdLigneScoreEquite", query = "SELECT l FROM LigneScoreEquite l WHERE l.idLigneScoreEquite = :idLigneScoreEquite"),
    @NamedQuery(name = "LigneScoreEquite.findByValeur", query = "SELECT l FROM LigneScoreEquite l WHERE l.valeur = :valeur"),
    @NamedQuery(name = "LigneScoreEquite.findByValDebut", query = "SELECT l FROM LigneScoreEquite l WHERE l.valDebut = :valDebut"),
    @NamedQuery(name = "LigneScoreEquite.findByValFin", query = "SELECT l FROM LigneScoreEquite l WHERE l.valFin = :valFin"),
    @NamedQuery(name = "LigneScoreEquite.findByPas", query = "SELECT l FROM LigneScoreEquite l WHERE l.pas = :pas"),
    @NamedQuery(name = "LigneScoreEquite.findByIdsousPeriode", query = "SELECT l FROM LigneScoreEquite l WHERE l.idsousPeriode = :idsousPeriode")})
public class LigneScoreEquite implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_ligne_score_equite")
    private Long idLigneScoreEquite;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double valeur;
    @Column(name = "val_debut")
    private Double valDebut;
    @Column(name = "val_fin")
    private Double valFin;
    private Double pas;
    @Column(name = "idsous_periode")
    private Integer idsousPeriode;
    @JoinColumn(name = "idcouverture", referencedColumnName = "idcouverturepopulation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Couverturepopulation idcouverture;
    @JoinColumn(name = "idrubrique_score", referencedColumnName = "id_rubrique_score_qualite")
    @ManyToOne(fetch = FetchType.LAZY)
    private RubriqueScoreQualite idrubriqueScore;

    public LigneScoreEquite() {
    }

    public LigneScoreEquite(Long idLigneScoreEquite) {
        this.idLigneScoreEquite = idLigneScoreEquite;
    }

    public Long getIdLigneScoreEquite() {
        return idLigneScoreEquite;
    }

    public void setIdLigneScoreEquite(Long idLigneScoreEquite) {
        this.idLigneScoreEquite = idLigneScoreEquite;
    }

    public Double getValeur() {
        return valeur;
    }

    public void setValeur(Double valeur) {
        this.valeur = valeur;
    }

    public Double getValDebut() {
        return valDebut;
    }

    public void setValDebut(Double valDebut) {
        this.valDebut = valDebut;
    }

    public Double getValFin() {
        return valFin;
    }

    public void setValFin(Double valFin) {
        this.valFin = valFin;
    }

    public Double getPas() {
        return pas;
    }

    public void setPas(Double pas) {
        this.pas = pas;
    }

    public Integer getIdsousPeriode() {
        return idsousPeriode;
    }

    public void setIdsousPeriode(Integer idsousPeriode) {
        this.idsousPeriode = idsousPeriode;
    }

    public Couverturepopulation getIdcouverture() {
        return idcouverture;
    }

    public void setIdcouverture(Couverturepopulation idcouverture) {
        this.idcouverture = idcouverture;
    }

    public RubriqueScoreQualite getIdrubriqueScore() {
        return idrubriqueScore;
    }

    public void setIdrubriqueScore(RubriqueScoreQualite idrubriqueScore) {
        this.idrubriqueScore = idrubriqueScore;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idLigneScoreEquite != null ? idLigneScoreEquite.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LigneScoreEquite)) {
            return false;
        }
        LigneScoreEquite other = (LigneScoreEquite) object;
        if ((this.idLigneScoreEquite == null && other.idLigneScoreEquite != null) || (this.idLigneScoreEquite != null && !this.idLigneScoreEquite.equals(other.idLigneScoreEquite))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.LigneScoreEquite[ idLigneScoreEquite=" + idLigneScoreEquite + " ]";
    }
    
}
