package domain;

public class Cart{
    private int cartid;
    private int productid;
    private int productqty;
    private int accountid;
    private int createdby;
    private String createdtime;
    private int updatedby;
    private String updatedtime;
    private boolean isactive;
    private int deletedby;
    private String deletedtime;

    public Cart() {
    }
    
    public Cart(int productid,int productqty){
        this.productid = productid;
        this.productqty = productqty;
    }

    public Cart(int accountid, int productid, int productqty,String time) {
        this.productid = productid;
        this.productqty = productqty;
        this.accountid = accountid;
        this.createdby = accountid;
        this.createdtime = time;
        this.updatedby = accountid;
        this.updatedtime = time;
        this.isactive = true;
    }
    
    public Cart(int cartid,int productid,int productqty, int accountid,int createdby, String createdtime,int updatedby,String updatedtime,boolean isactive,int deletedby, String deletedtime){
        this.cartid = cartid;
        this.productid = productid;
        this.productqty = productqty;
        this.accountid = accountid;
        this.createdby = createdby;
        this.createdtime = createdtime;
        this.updatedby = updatedby;
        this.updatedtime = updatedtime;
        this.isactive = isactive;
        this.deletedby = deletedby;
        this.deletedtime = deletedtime;
    }

    public Integer getCartID() {
        return cartid;
    }

    public void setCartID(int cartid) {
        this.cartid = cartid;
    }
    
    public int getProductID(){
        return productid;
    }
    
    public void setProductID(int productid){
        this.productid = productid;
    }
    
    public int getProductQty(){
        return productqty;
    }
    
    public void setProductQty(int productqty){
        this.productqty = productqty;
    }

    public int getAccountID() {
        return accountid;
    }

    public void setAccountID(int accountid) {
        this.accountid = accountid;
    }

    public int getCreatedBy() {
        return createdby;
    }

    public void setCreatedBy(int createdby) {
        this.createdby = createdby;
    }

    public String getCreatedTime() {
        return createdtime;
    }

    public void setCreatedTime(String createdtime) {
        this.createdtime = createdtime;
    }

    public int getUpdatedBy() {
        return updatedby;
    }

    public void setUpdatedBy(int updatedby) {
        this.updatedby = updatedby;
    }

    public String getUpdatedTime() {
        return updatedtime;
    }

    public void setUpdatedTime(String updatedtime) {
        this.updatedtime = updatedtime;
    }

    public boolean getIsActive() {
        return isactive;
    }

    public void setIsActive(boolean isactive) {
        this.isactive = isactive;
    }

    public int getDeletedBy() {
        return deletedby;
    }

    public void setDeletedBy(int deletedby) {
        this.deletedby = deletedby;
    }

    public String getDeletedTime() {
        return deletedtime;
    }

    public void setDeletedTime(String deletedtime) {
        this.deletedtime = deletedtime;
    }
}
