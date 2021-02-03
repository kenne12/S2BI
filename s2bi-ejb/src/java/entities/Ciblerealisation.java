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
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author USER
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Ciblerealisation.findAll", query = "SELECT c FROM Ciblerealisation c"),
    @NamedQuery(name = "Ciblerealisation.findByIdciblerealisation", query = "SELECT c FROM Ciblerealisation c WHERE c.idciblerealisation = :idciblerealisation"),
    @NamedQuery(name = "Ciblerealisation.findByValeurcible", query = "SELECT c FROM Ciblerealisation c WHERE c.valeurcible = :valeurcible"),
    @NamedQuery(name = "Ciblerealisation.findByValeurrealisee", query = "SELECT c FROM Ciblerealisation c WHERE c.valeurrealisee = :valeurrealisee"),
    @NamedQuery(name = "Ciblerealisation.findByCouverture", query = "SELECT c FROM Ciblerealisation c WHERE c.couverture = :couverture"),
    @NamedQuery(name = "Ciblerealisation.findByPas", query = "SELECT c FROM Ciblerealisation c WHERE c.pas = :pas"),
    @NamedQuery(name = "Ciblerealisation.findByValeurAnneeFin", query = "SELECT c FROM Ciblerealisation c WHERE c.valeurAnneeFin = :valeurAnneeFin"),
    @NamedQuery(name = "Ciblerealisation.findByCUnitaireDebut", query = "SELECT c FROM Ciblerealisation c WHERE c.cUnitaireDebut = :cUnitaireDebut"),
    @NamedQuery(name = "Ciblerealisation.findByCUnitaireFin", query = "SELECT c FROM Ciblerealisation c WHERE c.cUnitaireFin = :cUnitaireFin"),
    @NamedQuery(name = "Ciblerealisation.findByCoutUnitaire", query = "SELECT c FROM Ciblerealisation c WHERE c.coutUnitaire = :coutUnitaire"),
    @NamedQuery(name = "Ciblerealisation.findByPasCoutUnitaire", query = "SELECT c FROM Ciblerealisation c WHERE c.pasCoutUnitaire = :pasCoutUnitaire"),
    @NamedQuery(name = "Ciblerealisation.findByBudget", query = "SELECT c FROM Ciblerealisation c WHERE c.budget = :budget"),
    @NamedQuery(name = "Ciblerealisation.findByBaq", query = "SELECT c FROM Ciblerealisation c WHERE c.baq = :baq"),
    @NamedQuery(name = "Ciblerealisation.findByBonusQualite", query = "SELECT c FROM Ciblerealisation c WHERE c.bonusQualite = :bonusQualite"),
    @NamedQuery(name = "Ciblerealisation.findByBonusEquite", query = "SELECT c FROM Ciblerealisation c WHERE c.bonusEquite = :bonusEquite"),
    @NamedQuery(name = "Ciblerealisation.findByTotal1", query = "SELECT c FROM Ciblerealisation c WHERE c.total1 = :total1"),
    @NamedQuery(name = "Ciblerealisation.findByTotal2", query = "SELECT c FROM Ciblerealisation c WHERE c.total2 = :total2"),
    @NamedQuery(name = "Ciblerealisation.findByValCibleFin", query = "SELECT c FROM Ciblerealisation c WHERE c.valCibleFin = :valCibleFin"),
    @NamedQuery(name = "Ciblerealisation.findByPasValCible", query = "SELECT c FROM Ciblerealisation c WHERE c.pasValCible = :pasValCible")})
public class Ciblerealisation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idciblerealisation;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double valeurcible;
    private Double valeurrealisee;
    private Double couverture;
    private Double pas;
    @Column(name = "valeur_annee_fin")
    private Double valeurAnneeFin;
    @Column(name = "c_unitaire_debut")
    private Double cUnitaireDebut;
    @Column(name = "c_unitaire_fin")
    private Double cUnitaireFin;
    @Column(name = "cout_unitaire")
    private Double coutUnitaire;
    @Column(name = "pas_cout_unitaire")
    private Double pasCoutUnitaire;
    private Double budget;
    private Double baq;
    @Column(name = "bonus_qualite")
    private Double bonusQualite;
    @Column(name = "bonus_equite")
    private Double bonusEquite;
    private Double total1;
    private Double total2;
    @Column(name = "val_cible_fin")
    private Double valCibleFin;
    @Column(name = "pas_val_cible")
    private Double pasValCible;
    @JoinColumn(name = "idindicateur", referencedColumnName = "idindicateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Indicateur idindicateur;
    @JoinColumn(name = "idperiode", referencedColumnName = "idperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Periode idperiode;
    @JoinColumn(name = "idsousperiode", referencedColumnName = "idsousperiode")
    @ManyToOne(fetch = FetchType.LAZY)
    private Sousperiodecosting idsousperiode;
    @JoinColumn(name = "iduniteorganisation", referencedColumnName = "iduniteorganisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Uniteorganisation iduniteorganisation;

    public Ciblerealisation() {
    }

    public Ciblerealisation(Long idciblerealisation) {
        this.idciblerealisation = idciblerealisation;
    }

    public Long getIdciblerealisation() {
        return idciblerealisation;
    }

    public void setIdciblerealisation(Long idciblerealisation) {
        this.idciblerealisation = idciblerealisation;
    }

    public Double getValeurcible() {
        return valeurcible;
    }

    public void setValeurcible(Double valeurcible) {
        this.valeurcible = valeurcible;
    }

    public Double getValeurrealisee() {
        return valeurrealisee;
    }

    public void setValeurrealisee(Double valeurrealisee) {
        this.valeurrealisee = valeurrealisee;
    }

    public Double getCouverture() {
        return couverture;
    }

    public void setCouverture(Double couverture) {
        this.couverture = couverture;
    }

    public Double getPas() {
        return pas;
    }

    public void setPas(Double pas) {
        this.pas = pas;
    }

    public Double getValeurAnneeFin() {
        return valeurAnneeFin;
    }

    public void setValeurAnneeFin(Double valeurAnneeFin) {
        this.valeurAnneeFin = valeurAnneeFin;
    }

    public Double getCUnitaireDebut() {
        return cUnitaireDebut;
    }

    public void setCUnitaireDebut(Double cUnitaireDebut) {
        this.cUnitaireDebut = cUnitaireDebut;
    }

    public Double getCUnitaireFin() {
        return cUnitaireFin;
    }

    public void setCUnitaireFin(Double cUnitaireFin) {
        this.cUnitaireFin = cUnitaireFin;
    }

    public Double getCoutUnitaire() {
        return coutUnitaire;
    }

    public void setCoutUnitaire(Double coutUnitaire) {
        this.coutUnitaire = coutUnitaire;
    }

    public Double getPasCoutUnitaire() {
        return pasCoutUnitaire;
    }

    public void setPasCoutUnitaire(Double pasCoutUnitaire) {
        this.pasCoutUnitaire = pasCoutUnitaire;
    }

    public Double getBudget() {
        return budget;
    }

    public void setBudget(Double budget) {
        this.budget = budget;
    }

    public Double getBaq() {
        return baq;
    }

    public void setBaq(Double baq) {
        this.baq = baq;
    }

    public Double getBonusQualite() {
        return bonusQualite;
    }

    public void setBonusQualite(Double bonusQualite) {
        this.bonusQualite = bonusQualite;
    }

    public Double getBonusEquite() {
        return bonusEquite;
    }

    public void setBonusEquite(Double bonusEquite) {
        this.bonusEquite = bonusEquite;
    }

    public Double getTotal1() {
        return total1;
    }

    public void setTotal1(Double total1) {
        this.total1 = total1;
    }

    public Double getTotal2() {
        return total2;
    }

    public void setTotal2(Double total2) {
        this.total2 = total2;
    }

    public Double getValCibleFin() {
        return valCibleFin;
    }

    public void setValCibleFin(Double valCibleFin) {
        this.valCibleFin = valCibleFin;
    }

    public Double getPasValCible() {
        return pasValCible;
    }

    public void setPasValCible(Double pasValCible) {
        this.pasValCible = pasValCible;
    }

    public Indicateur getIdindicateur() {
        return idindicateur;
    }

    public void setIdindicateur(Indicateur idindicateur) {
        this.idindicateur = idindicateur;
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
        hash += (idciblerealisation != null ? idciblerealisation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ciblerealisation)) {
            return false;
        }
        Ciblerealisation other = (Ciblerealisation) object;
        if ((this.idciblerealisation == null && other.idciblerealisation != null) || (this.idciblerealisation != null && !this.idciblerealisation.equals(other.idciblerealisation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Ciblerealisation[ idciblerealisation=" + idciblerealisation + " ]";
    }
    
}
