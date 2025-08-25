package domain;

public class Order {
    private int orderId;
    private String orderDate;
    private int productId; // Changed from productID
    private int productQty; // Changed from productQty
    private String shippingAddress;
    private String completionDate;
    private String status;
    private int accountId;

    // Constructors, getters, and setters
    // Constructor
    public Order() {}
    
    public Order(int orderId,int productId,int productQty,int accountId,String orderDate,String shippingAddress){
        this.orderId = orderId;
        this.productId = productId;
        this.productQty = productQty;
        this.accountId = accountId;
        this.orderDate = orderDate;
        this.shippingAddress = shippingAddress;
    }

    public Order(int orderId, String orderDate, int productId, int productQty, String shippingAddress, String completionDate, String status, int accountId) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.productId = productId;
        this.productQty = productQty;
        this.shippingAddress = shippingAddress;
        this.completionDate = completionDate;
        this.status = status;
        this.accountId = accountId;
    }

    // Getters and setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getProductQty() {
        return productQty;
    }

    public void setProductQty(int productQty) {
        this.productQty = productQty;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getCompletionDate() {
        return completionDate;
    }

    public void setCompletionDate(String completionDate) {
        this.completionDate = completionDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }
}
