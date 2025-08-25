//package da;
//
//import domain.ProductLine;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Time;
//import java.time.LocalTime;
//import java.util.ArrayList;
//
//public class ProductLineDA {
//
//    private String host = "jdbc:derby://localhost:1527/milogoh";
//    private String user = "nbuser";
//    private String password = "nbuser";
//    private String tableName = "ProductLine";
//    private Connection conn;
//    private PreparedStatement stmt;
//
//    public ProductLineDA() throws Exception {
//        createConnection();
//    }
//
//    public ProductLine getRecord(int productLineId) throws Exception{
//        String queryStr = "SELECT * FROM" + tableName + "WHERE PRODUCTLINEID = ?";
//        ProductLine productLine = null;
//        try {
//            stmt = conn.prepareStatement(queryStr);
//            stmt.setInt(1, productLineId);
//            ResultSet rs = stmt.executeQuery();
//
//            if (rs.next()) {
//                int productLineID = rs.getInt("productlineid");
//                int quantity = rs.getInt("quantity");
//                int createdBy = rs.getInt("createdby");
//                Time createdTime = rs.getTime("createdtime");
//                int updatedBy = rs.getInt("updatedby");
//                Time updatedTime = rs.getTime("updatedtime");
//                boolean isActive = rs.getBoolean("isactive");
//                int deletedBy = rs.getInt("deletedby");
//                Time deletedTime = rs.getTime("deletedtime");
//                int productID = rs.getInt("productid");
//
//                productLine = new ProductLine(productLineID, quantity, createdBy, createdTime, updatedBy, updatedTime, isActive, deletedBy, deletedTime, productID);
//            }
//        } catch (SQLException ex) {
//            throw ex;
//        }
//        return productLine;
//    }
//
//    public ArrayList<ProductLine> getAllRecord() throws Exception{
//        String queryStr = "SELECT * FROM" + tableName;
//        ArrayList<ProductLine> productLineList = new ArrayList<>();
//        try {
//            stmt = conn.prepareStatement(queryStr);
//            ResultSet rs = stmt.executeQuery();
//
//            while (rs.next()) {
//                int productLineID = rs.getInt("productlineid");
//                int quantity = rs.getInt("quantity");
//                int createdBy = rs.getInt("createdby");
//                Time createdTime = rs.getTime("createdtime");
//                int updatedBy = rs.getInt("updatedby");
//                Time updatedTime = rs.getTime("updatedtime");
//                boolean isActive = rs.getBoolean("isactive");
//                int deletedBy = rs.getInt("deletedby");
//                Time deletedTime = rs.getTime("deletedtime");
//                int productID = rs.getInt("productid");
//
//                ProductLine productLine = new ProductLine(productLineID, quantity, createdBy, createdTime, updatedBy, updatedTime, isActive, deletedBy, deletedTime, productID);
//                productLineList.add(productLine);
//            }
//        } catch (SQLException ex) {
//            throw ex;
//        }
//        return productLineList;
//    }
//
//    public void addRecord(ProductLine productLine) throws Exception {
//        String insertStr = "INSERT INTO " + tableName + "(productlineid,quantity,createdby,createdtime,updatedby,updatedtime,isactive,deletedby,deletedtime,productid) VALUES (?,?,?,?,?,?,?,?,?,?)";
//
//        LocalTime localTime = LocalTime.now();
//        Time insertTime = Time.valueOf(localTime);
//        try {
//            stmt = conn.prepareStatement(insertStr);
//            
//            stmt.setInt(1,productLine.getProductLineID());
//            stmt.setInt(2, productLine.getQuantity());
//            stmt.setInt(3, productLine.getCreatedBy());
//            stmt.setTime(4,insertTime);
//            stmt.setInt(5, productLine.getUpdatedBy());
//            stmt.setTime(6, insertTime);
//            stmt.setBoolean(7,productLine.getIsActive());
//            stmt.setInt(8, 0);
//            stmt.setTime(9, null);
//            stmt.setInt(10,productLine.getProductID());
//            
//            stmt.executeUpdate();
//        } catch (SQLException ex) {
//            throw ex;
//        }
//    }
//
//    public void deleteRecord(int productlineId) throws Exception {
//        String deleteStr = "DELETE FROM " + tableName + "WHERE productlineid = ?";
//        try {
//            stmt = conn.prepareStatement(deleteStr);
//            stmt.setInt(1, productlineId);
//            stmt.executeUpdate();
//        } catch (SQLException ex) {
//            throw ex;
//        }
//    }
//
//    public void editRecord(ProductLine productLine) throws Exception {
//        String updateStr = "UPDATE " + tableName + "SET quantity = ?, createdby = ?, createdtime = ?, updatedby = ?, updatedtime = ?, isactive = ?, deletedby = ?, deletedtime = ?, productid = ? WHERE productlineid = ?";
//        
//        LocalTime localTime = LocalTime.now();
//        Time insertTime = Time.valueOf(localTime);
//        try {
//            stmt = conn.prepareStatement(updateStr);
//            stmt.setInt(1, productLine.getQuantity());
//            stmt.setInt(2, productLine.getCreatedBy());
//            stmt.setTime(3,insertTime);
//            stmt.setInt(4, productLine.getUpdatedBy());
//            stmt.setTime(5, insertTime);
//            stmt.setBoolean(6,productLine.getIsActive());
//            stmt.setInt(7, productLine.getDeletedBy());
//            stmt.setTime(8, productLine.getDeletedTime());
//            stmt.setInt(9,productLine.getProductID());
//            stmt.setInt(10,productLine.getProductLineID());
//            stmt.executeUpdate();
//        } catch (SQLException ex) {
//            throw ex;
//        }
//    }
//
//    private void createConnection() throws Exception {
//        try {
//            Class.forName("org.apache.derby.jdbc.ClientDriver");
//            conn = DriverManager.getConnection(host, user, password);
//            System.out.println("***TRACE: Connection established.");
//        } catch (SQLException ex) {
//            throw ex;
//        }
//    }
//}
