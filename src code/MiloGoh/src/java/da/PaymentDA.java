/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.Payment;
import da.OrderDA;
import domain.Order;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import javax.swing.JOptionPane;

/**
 *
 * @author limch
 */
public class PaymentDA {

    private String host = "jdbc:derby://localhost:1527/milogoh";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "PAYMENT";
    private Connection conn;
    private PreparedStatement stmt;
    private OrderDA orderDA = new OrderDA();

    public PaymentDA() {
        createConnection();
    }

    public ArrayList<Payment> getAllPayments() {
        String queryStr = "SELECT * FROM " + tableName;
        ArrayList<Payment> payments = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Payment payment = extractPaymentFromResultSet(rs);
                payments.add(payment);
            }
        } catch (SQLException ex) {

        }
        return payments;
    }

    public Payment getRecord(int paymentId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE paymentid = ?";
        Payment payment = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, paymentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Extract payment details from ResultSet and create a Payment object
                int orderId = rs.getInt("orderid");
                double totalPayment = rs.getDouble("totalpayment");
                String status = rs.getString("status");

                // Create a Payment object with retrieved values
                payment = new Payment(paymentId, orderId, totalPayment, status);
            }

        } catch (SQLException ex) {

        }
        return payment;
    }

    public Payment getRecordByOrderId(int orderId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE orderid = ?";
        Payment payment = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Extract payment details from ResultSet and create a Payment object
                int paymentId = rs.getInt("paymentid");
                double totalPayment = rs.getDouble("totalpayment");
                String status = rs.getString("status");

                // Create a Payment object with retrieved values
                payment = new Payment(paymentId, orderId, totalPayment, status);
            }

        } catch (SQLException ex) {

        }
        return payment;
    }

    public ArrayList<Payment> getAllRecordByAccountId(int accountId) {
        ArrayList<Order> orderList = orderDA.getOrdersByAccountId(accountId);
        ArrayList<Payment> paymentList = new ArrayList<>();
        if (!orderList.isEmpty()) {
            for (int i = 0; i < orderList.size(); i++) {
                Payment payment = this.getRecordByOrderId(orderList.get(i).getOrderId());
                paymentList.add(payment);
            }
        }
        return paymentList;
    }

    private Payment extractPaymentFromResultSet(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setPaymentId(rs.getInt("paymentid"));
        payment.setOrderId(rs.getInt("orderid"));
        payment.setTotalPayment(rs.getDouble("totalpayment"));
        payment.setStatus(rs.getString("status"));
        return payment;
    }
    
    
     
    public void addPayment(Payment payment) {
        

        // Prepare and execute the SQL query to insert the payment data into the database
        String insertStr = "INSERT INTO " + tableName + " (paymentID, orderid, totalpayment, status) VALUES (?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setInt(1, payment.getPaymentId());
            stmt.setInt(2, payment.getOrderId());
            stmt.setDouble(3, payment.getTotalPayment());
            stmt.setString(4, payment.getStatus());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            // Handle any potential exceptions
        }
    }

    public void updatePayment(Payment payment) {
        String updateStr = "UPDATE " + tableName + " SET orderid = ?, totalpayment = ?, status = ? WHERE paymentid = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1, payment.getOrderId());
            stmt.setDouble(2, payment.getTotalPayment());
            stmt.setString(3, payment.getStatus());
            stmt.setInt(4, payment.getPaymentId());
            stmt.executeUpdate();
        } catch (SQLException ex) {

        }
    }

    public void deletePayment(int paymentId) {
        String deleteStr = "DELETE FROM " + tableName + " WHERE paymentid = ?";
        try {
            stmt = conn.prepareStatement(deleteStr);
            stmt.setInt(1, paymentId);
            stmt.executeUpdate();
        } catch (SQLException ex) {

        }
    }

    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
            System.out.println("***TRACE: Connection established.");
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void shutDown() {
        if (conn != null)
            try {
            conn.close();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
}
