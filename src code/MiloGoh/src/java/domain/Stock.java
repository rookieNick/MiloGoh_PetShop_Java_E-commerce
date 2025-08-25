/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;


/**
 *
 * @author terra
 */
public class Stock {
    private Product product;
    private int qty;
    private String createdDate;
    private String updateTime;
    private String updatedBy;
    private String createdBy;
    private String deletedBy;
    private String isActive;
    
    public Stock (){
        
    }
    public Stock(Product pdt){
        this.product = pdt;
    }
    public Stock(Product pdt, int qty){
        this.product = pdt;
        this.qty = qty;
    }
    // Getter for 'id'
    public int getProduct() {
        return  product.getId();
        
    }

    // Getter for 'qty'
    public int getQty() {
        return qty;
    }

    // Setter for 'qty'
    public void setQty(int qty) {
        this.qty = qty;
    }
    
     // Getters and setters for 'createdDate'
    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    // Getters and setters for 'updateTime'
    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    // Getters and setters for 'updatedBy'
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    // Getters and setters for 'createdBy'
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    // Getters and setters for 'deletedBy'
    public String getDeletedBy() {
        return deletedBy;
    }

    public void setDeletedBy(String deletedBy) {
        this.deletedBy = deletedBy;
    }

    // Getters and setters for 'isActive'
    public String getIsActive() {
        return isActive;
    }

    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }
}
