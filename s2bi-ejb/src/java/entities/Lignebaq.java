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
    @NamedQuery(name = "Lignebaq.findAll", query = "SELECT l FROM Lignebaq l"),
    @NamedQuery(name = "Lignebaq.findByIdLignebaq", query = "SELECT l FROM Lignebaq l WHERE l.idLignebaq = :idLignebaq"),
    @NamedQuery(name = "Lignebaq.findByQuantite", query = "SELECT l FROM Lignebaq l WHERE l.quantite = :quantite"),
    @NamedQuery(name = "Lignebaq.findByCoutUnitaire", query = "SELECT l FROM Lignebaq l WHERE l.coutUnitaire = :coutUnitaire"),
    @NamedQuery(name = "Lignebaq.findByTotal", query = "SELECT l FROM Lignebaq l WHERE l.total = :total"),
    @NamedQuery(name = "Lignebaq.findByQteDebut", query = "SELECT l FROM Lignebaq l WHERE l.qteDebut = :qteDebut"),
    @NamedQuery(name = "Lignebaq.findByQteFin", query = "SELECT l FROM Lignebaq l WHERE l.qteFin = :qteFin"),
    @NamedQuery(name = "Lignebaq.findByCuDebut", query = "SELECT l FROM Lignebaq l WHERE l.cuDebut = :cuDebut"),
    @NamedQuery(name = "Lignebaq.findByCuFin", query = "SELECT l FROM Lignebaq l WHERE l.cuFin = :cuFin"),
    @NamedQuery(name = "Lignebaq.findByIdsousPeriode", query = "SELECT l FROM Lignebaq l WHERE l.idsousPeriode = :idsousPeriode"),
    @NamedQuery(name = "Lignebaq.findByQtePas", query = "SELECT l FROM Lignebaq l WHERE l.qtePas = :qtePas"),
    @NamedQuery(name = "Lignebaq.findByCuPas", query = "SELECT l FROM Lignebaq l WHERE l.cuPas = :cuPas")})
public class Lignebaq implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_lignebaq")
    private Long idLignebaq;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double quantite;
    @Column(name = "cout_unitaire")
    private Double coutUnitaire;
    private Double total;
    @Column(name = "qte_debut")
    private Double qteDebut;
    @Column(name = "qte_fin")
    private Double qteFin;
    @Column(name = "cu_debut")
    private Double cuDebut;
    @Column(name = "cu_fin")
    private Double cuFin;
    @Column(name = "idsous_periode")
    private Integer idsousPeriode;
    @Column(name = "qte_pas")
    private Double qtePas;
    @Column(name = "cu_pas")
    private Double cuPas;
    @JoinColumn(name = "idcouverture", referencedColumnName = "idcouverturepopulation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Couverturepopulation idcouverture;
    @JoinColumn(name = "id_type_baq", referencedColumnName = "id_type_baq")
    @ManyToOne(fetch = FetchType.LAZY)
    private TypeBaq idTypeBaq;

    public Lignebaq() {
    }

    public Lignebaq(Long idLignebaq) {
        this.idLignebaq = idLignebaq;
    }

    public Long getIdLignebaq() {
        return idLignebaq;
    }

    public void setIdLignebaq(Long idLignebaq) {
        this.idLignebaq = idLignebaq;
    }

    public Double getQuantite() {
        return quantite;
    }

    public void setQuantite(Double quantite) {
        this.quantite = quantite;
    }

    public Double getCoutUnitaire() {
        return coutUnitaire;
    }

    public void setCoutUnitaire(Double coutUnitaire) {
        this.coutUnitaire = coutUnitaire;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getQteDebut() {
        return qteDebut;
    }

    public void setQteDebut(Double qteDebut) {
        this.qteDebut = qteDebut;
    }

    public Double getQteFin() {
        return qteFin;
    }

    public void setQteFin(Double qteFin) {
        this.qteFin = qteFin;
    }

    public Double getCuDebut() {
        return cuDebut;
    }

    public void setCuDebut(Double cuDebut) {
        this.cuDebut = cuDebut;
    }

    public Double getCuFin() {
        return cuFin;
    }

    public void setCuFin(Double cuFin) {
        this.cuFin = cuFin;
    }

    public Integer getIdsousPeriode() {
        return idsousPeriode;
    }

    public void setIdsousPeriode(Integer idsousPeriode) {
        this.idsousPeriode = idsousPeriode;
    }

    public Double getQtePas() {
        return qtePas;
    }

    public void setQtePas(Double qtePas) {
        this.qtePas = qtePas;
    }

    public Double getCuPas() {
        return cuPas;
    }

    public void setCuPas(Double cuPas) {
        this.cuPas = cuPas;
    }

    public Couverturepopulation getIdcouverture() {
        return idcouverture;
    }

    public void setIdcouverture(Couverturepopulation idcouverture) {
        this.idcouverture = idcouverture;
    }

    public TypeBaq getIdTypeBaq() {
        return idTypeBaq;
    }

    public void setIdTypeBaq(TypeBaq idTypeBaq) {
        this.idTypeBaq = idTypeBaq;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idLignebaq != null ? idLignebaq.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Lignebaq)) {
            return false;
        }
        Lignebaq other = (Lignebaq) object;
        if ((this.idLignebaq == null && other.idLignebaq != null) || (this.idLignebaq != null && !this.idLignebaq.equals(other.idLignebaq))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Lignebaq[ idLignebaq=" + idLignebaq + " ]";
    }
    
}
