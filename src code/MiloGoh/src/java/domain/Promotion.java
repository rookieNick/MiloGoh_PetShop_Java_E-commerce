/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author zlsy2
 */
@Entity
@Table(name = "PROMOTION")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Promotion.findAll", query = "SELECT p FROM Promotion p"),
    @NamedQuery(name = "Promotion.findByStatusAndDate", query = "SELECT p FROM Promotion p WHERE p.status = :status AND p.validdate = :validdate"),
    @NamedQuery(name = "Promotion.findByPromotionid", query = "SELECT p FROM Promotion p WHERE p.promotionid = :promotionid"),
    @NamedQuery(name = "Promotion.findByDiscount", query = "SELECT p FROM Promotion p WHERE p.discount = :discount"),
    @NamedQuery(name = "Promotion.findByStatus", query = "SELECT p FROM Promotion p WHERE p.status = :status"),
    @NamedQuery(name = "Promotion.findByDescription", query = "SELECT p FROM Promotion p WHERE p.description = :description"),
    @NamedQuery(name = "Promotion.findByValiddate", query = "SELECT p FROM Promotion p WHERE p.validdate = :validdate")})
public class Promotion implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "PROMOTIONID")
    private Integer promotionid;
    @Column(name = "DISCOUNT")
    private Integer discount;
    @Column(name = "STATUS")
    private Boolean status;
    @Size(max = 200)
    @Column(name = "DESCRIPTION")
    private String description;
    @Size(max = 200)
    @Column(name = "VALIDDATE")
    private String validdate;

    public Promotion() {
    }

    public Promotion(Integer promotionid) {
        this.promotionid = promotionid;
    }
    
    public Promotion(int discount,String validdate,String description){
        this.discount = discount;
        this.status = false;
        this.validdate = validdate;
        this.description = description;
    }
    
    public Promotion(int promotionid, int discount,String validdate,String description){
        this.promotionid = promotionid;
        this.discount = discount;
        this.validdate = validdate;
        this.description = description;
    }

    public Integer getPromotionid() {
        return promotionid;
    }

    public void setPromotionid(Integer promotionid) {
        this.promotionid = promotionid;
    }

    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getValiddate() {
        return validdate;
    }

    public void setValiddate(String validdate) {
        this.validdate = validdate;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (promotionid != null ? promotionid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Promotion)) {
            return false;
        }
        Promotion other = (Promotion) object;
        if ((this.promotionid == null && other.promotionid != null) || (this.promotionid != null && !this.promotionid.equals(other.promotionid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "domain.Promotion[ promotionid=" + promotionid + " ]";
    }
    
}
