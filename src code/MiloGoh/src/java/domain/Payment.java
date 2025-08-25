package domain;

public class Payment {
    private int paymentId;
    private int orderId;
    private double totalPayment;
    private String status;

    public Payment() {
    }

    public Payment(int paymentId, int orderId, double totalPayment, String status) {
        this.paymentId = paymentId;
        this.orderId = orderId;
        this.totalPayment = totalPayment;
        this.status = status;
    }

    // Getters and setters
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public double getTotalPayment() {
        return totalPayment;
    }

    public void setTotalPayment(double totalPayment) {
        this.totalPayment = totalPayment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

