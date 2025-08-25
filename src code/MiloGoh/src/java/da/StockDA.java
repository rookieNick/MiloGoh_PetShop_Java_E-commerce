/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.Product;
import domain.Stock;
import java.sql.*;
import javax.swing.*;

/**
 *
 * @author terra
 */
public class StockDA {
    private String host = "jdbc:derby://localhost:1527/milogoh";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "stock";
    private Connection conn;
    private PreparedStatement stmt;
    
    //to get the product id
    private ProductDA productDA = new ProductDA();
    
    public StockDA() {
        createConnection();
    }
    
    public Stock getStock(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        Stock stock = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            //get product ID
            Product product = productDA.getProductById(id);
            
            
            if (rs.next()) {
                stock = new Stock(product, rs.getInt("qty"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return stock;
    }
    
    public void addStock(Stock s){
        String inserStr = "Insert into " + tableName + " values (?,?) ";
        try{
            stmt = conn.prepareStatement(inserStr);
            stmt.setInt(1,s.getProduct());
            stmt.setInt(2,s.getQty());

            stmt.executeUpdate();


        
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    public void updateStock(Stock s){
        String updateStr = "Update " + tableName + " SET qty = ?, where id = ? ";
        try{
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1,s.getQty());
            stmt.setInt(2,s.getProduct());

            stmt.executeUpdate();


        
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    public void deleteStock(Stock s){
        String deleteStr = "Delete from " + tableName + " where id = ? ";
        try{
            stmt = conn.prepareStatement(deleteStr);
            stmt.setInt(1,s.getProduct());
            stmt.executeUpdate();


        
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
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
