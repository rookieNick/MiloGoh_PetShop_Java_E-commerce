//package domain;
//
//import java.sql.Time;
//import java.time.LocalTime;
//
//public class ProductLine {
//
//    private int productlineid;
//    private int quantity;
//    private int createdby;
//    private Time createdtime;
//    private int updatedby;
//    private Time updatedtime;
//    private boolean isactive;
//    private int deletedby;
//    private Time deletedtime;
//    private int productid;
//
//    public ProductLine() {
//    }
//    
//    public ProductLine(int productlineid,int productId, int quantity, int accountId){
//        LocalTime localTime = LocalTime.now();
//        this.productlineid = productlineid;
//        this.quantity = quantity;
//        this.createdby = accountId;
//        this.createdtime = Time.valueOf(localTime);
//        this.updatedby = accountId;
//        this.updatedtime = Time.valueOf(localTime);
//        this.isactive = true;
//        this.deletedby = 0;
//        this.deletedtime = null;
//        this.productid = productId;
//    }
//    
//    public ProductLine(int productlineid, int quantity, int createdby, Time createdtime, int updatedby, Time updatedtime,boolean isactive, int deletedby, Time deletedtime, int productid){
//        this.productlineid = productlineid;
//        this.quantity = quantity;
//        this.createdby = createdby;
//        this.createdtime = createdtime;
//        this.updatedby = updatedby;
//        this.updatedtime = updatedtime;
//        this.isactive = isactive;
//        this.deletedby = deletedby;
//        this.deletedtime = deletedtime;
//        this.productid = productid;
//    }
//
//    public Integer getProductLineID() {
//        return productlineid;
//    }
//
//    public void setProductLineID(Integer productlineid) {
//        this.productlineid = productlineid;
//    }
//
//    public Integer getQuantity() {
//        return quantity;
//    }
//
//    public void setQuantity(Integer quantity) {
//        this.quantity = quantity;
//    }
//
//    public Integer getCreatedBy() {
//        return createdby;
//    }
//
//    public void setCreatedBy(Integer createdby) {
//        this.createdby = createdby;
//    }
//
//    public Time getCreatedTime() {
//        return createdtime;
//    }
//
//    public void setCreatedTime(Time createdtime) {
//        this.createdtime = createdtime;
//    }
//
//    public Integer getUpdatedBy() {
//        return updatedby;
//    }
//
//    public void setUpdatedBy(Integer updatedby) {
//        this.updatedby = updatedby;
//    }
//
//    public Time getUpdatedTime() {
//        return updatedtime;
//    }
//
//    public void setUpdatedTime(Time updatedtime) {
//        this.updatedtime = updatedtime;
//    }
//
//    public Boolean getIsActive() {
//        return isactive;
//    }
//
//    public void setIsActive(Boolean isactive) {
//        this.isactive = isactive;
//    }
//
//    public Integer getDeletedBy() {
//        return deletedby;
//    }
//
//    public void setDeletedBy(Integer deletedby) {
//        this.deletedby = deletedby;
//    }
//
//    public Time getDeletedTime() {
//        return deletedtime;
//    }
//
//    public void setDeletedTime(Time deletedtime) {
//        this.deletedtime = deletedtime;
//    }
//
//    public int getProductID() {
//        return productid;
//    }
//
//    public void setProductID(int productid) {
//        this.productid = productid;
//    }
//
//}
