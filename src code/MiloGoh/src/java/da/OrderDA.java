/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.Order;
import domain.Product;

import javax.swing.JOptionPane;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author limch
 */
public class OrderDA {

    private String host = "jdbc:derby://localhost:1527/milogoh";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "ORDERS";
    private Connection conn;
    private PreparedStatement stmt;
    private ProductDA productDA;

    public OrderDA() {
        createConnection();
        productDA = new ProductDA();
    }

    public ArrayList<Order> getAllOrders() {
        String queryStr = "SELECT * FROM " + tableName;
        ArrayList<Order> orders = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = extractOrderFromResultSet(rs);
                orders.add(order);
            }
        } catch (SQLException ex) {

        }
        return orders;
    }

    public ArrayList<Order> getOrdersByOrderId(int orderId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE orderid = ?";
        ArrayList<Order> orders = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Retrieve all column values from ResultSet
                int orderid = rs.getInt("orderid");
                int productid = rs.getInt("productid");
                int productqty = rs.getInt("productqty");
                String shippingaddress = rs.getString("shippingaddress");
                String status = rs.getString("status");
                int accountid = rs.getInt("accountid");
                String orderDate = rs.getString("orderdate");
                String completionDate = rs.getString("completiondate");

                Order order = new Order(orderid, orderDate, productid, productqty, shippingaddress, completionDate, status, accountid);
                orders.add(order);
            }
        } catch (SQLException ex) {

        }
        return orders;
    }

    public Order getOrdersByOrderIdAndProductId(int orderId, int productId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE orderid = ? AND productid = ?";
        Order order = null; // Change return type to Order
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, orderId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve all column values from ResultSet
                int orderid = rs.getInt("orderid");
                int productid = rs.getInt("productid");
                int productqty = rs.getInt("productqty");
                String shippingaddress = rs.getString("shippingaddress");
                String status = rs.getString("status");
                int accountid = rs.getInt("accountid");
                String orderDate = rs.getString("orderdate");
                String completionDate = rs.getString("completiondate");

                // Create Order object with retrieved values
                order = new Order(orderid, orderDate, productid, productqty, shippingaddress, completionDate, status, accountid);
            }
        } catch (SQLException ex) {
            // Handle exception
        }
        return order;
    }

    public ArrayList<Order> getOrdersByStatus(String Status) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE status = ?";
        ArrayList<Order> orders = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, Status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Retrieve all column values from ResultSet
                int orderid = rs.getInt("orderid");
                int productid = rs.getInt("productid");
                int productqty = rs.getInt("productqty");
                String shippingaddress = rs.getString("shippingaddress");
                String status = rs.getString("status");
                int accountid = rs.getInt("accountid");
                String orderDate = rs.getString("orderdate");
                String completionDate = rs.getString("completiondate");

                Order order = new Order(orderid, orderDate, productid, productqty, shippingaddress, completionDate, status, accountid);
                orders.add(order);
            }
        } catch (SQLException ex) {

        }
        return orders;
    }

    public ArrayList<Order> getOrdersByAccountId(int accountId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE accountid = ?";
        ArrayList<Order> orders = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(queryStr);

            stmt.setInt(1, accountId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = extractOrderFromResultSet(rs);
                orders.add(order);
            }
        } catch (SQLException ex) {

        }
        return orders;
    }

    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("orderid"));
        order.setProductId(rs.getInt("productid"));
        order.setProductQty(rs.getInt("productqty"));
        order.setShippingAddress(rs.getString("shippingaddress"));
        order.setOrderDate(rs.getString("orderdate"));
        order.setCompletionDate(rs.getString("completiondate"));
        order.setStatus(rs.getString("status"));
        order.setAccountId(rs.getInt("accountid"));
        return order;
    }

    public void addOrder(Order order) {
        String insertStr = "INSERT INTO " + tableName + " (productid, productqty, shippingaddress, orderdate, completiondate, status, accountId, orderId) VALUES (?, ?, ?, ?, ?, ?, ?,?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setInt(1, order.getProductId());
            stmt.setInt(2, order.getProductQty());
            stmt.setString(3, order.getShippingAddress());
            stmt.setString(4, order.getOrderDate());
            stmt.setString(5, order.getCompletionDate());
            stmt.setString(6, "Unpaid");
            stmt.setInt(7, order.getAccountId());
            stmt.setInt(8, order.getOrderId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(); // Add proper error handling
        }
    }

    public void updateOrder(Order order) {
        String updateStr = "UPDATE " + tableName + " SET productid = ?, productqty = ?, shippingaddress = ?, orderdate = ?, completiondate = ?, status = ? , accountId = ? WHERE orderid = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1, order.getProductId());
            stmt.setInt(2, order.getProductQty());
            stmt.setString(3, order.getShippingAddress());
            stmt.setString(4, order.getOrderDate());
            stmt.setString(5, order.getCompletionDate());
            stmt.setString(6, order.getStatus());
            stmt.setInt(7, order.getAccountId());
            stmt.setInt(8, order.getOrderId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(); // Add proper error handling
        }
    }
    
    public void updateOrderWithDifferentProductId(Order order) {
        String updateStr = "UPDATE " + tableName + " SET productqty = ?, shippingaddress = ?, orderdate = ?, completiondate = ?, status = ? , accountId = ? WHERE orderid = ? AND productid = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1, order.getProductQty());
            stmt.setString(2, order.getShippingAddress());
            stmt.setString(3, order.getOrderDate());
            stmt.setString(4, order.getCompletionDate());
            stmt.setString(5, order.getStatus());
            stmt.setInt(6, order.getAccountId());
            stmt.setInt(7, order.getOrderId());
            stmt.setInt(8, order.getProductId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(); // Add proper error handling
        }
    }

    public void deleteOrder(int orderId) {
        String deleteStr = "DELETE FROM " + tableName + " WHERE orderid = ?";
        try {
            stmt = conn.prepareStatement(deleteStr);
            stmt.setInt(1, orderId);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(); // Add proper error handling
        }
    }

    public double totalPrice(ArrayList<Order> order) throws Exception {
        try {
            double totalPrice = 0;
            for (Order o : order) {
                Product product = productDA.getProductById(o.getProductId());
                if (product != null) {
                    totalPrice += product.getUnitPrice() * o.getProductQty();
                }
            }
            return totalPrice;
        } catch (Exception ex) {
            throw ex;
        }
    }

    private void createConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
            System.out.println("***TRACE: Connection established.");
        } catch (SQLException ex) {

        } catch (ClassNotFoundException ex) {

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
