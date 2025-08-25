package da;

import domain.Cart;
import domain.Product;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class CartDA {

    private String host = "jdbc:derby://localhost:1527/milogoh";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Cart";
    private Connection conn;
    private PreparedStatement stmt;
    private ProductDA productDA;

    public CartDA() throws Exception {
        this.productDA = new ProductDA();
        createConnection();
    }

    public Cart getRecord(int cartId) throws Exception {
        String queryStr = "SELECT * FROM" + tableName + "WHERE CARTID = ?";
        Cart cart = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int cartID = rs.getInt("cartid");
                int productID = rs.getInt("productid");
                int productQty = rs.getInt("productqty");
                int accountID = rs.getInt("accountid");
                int createdBy = rs.getInt("createdby");
                String createdTime = rs.getString("createdtime");
                int updatedBy = rs.getInt("updatedby");
                String updatedTime = rs.getString("updatedtime");
                boolean isActive = rs.getBoolean("isactive");
                int deletedBy = rs.getInt("deletedby");
                String deletedTime = rs.getString("deletedtime");

                cart = new Cart(cartID, productID, productQty, accountID, createdBy, createdTime, updatedBy, updatedTime, isActive, deletedBy, deletedTime);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return cart;
    }

    public Cart getRecordByAccountIdAndProductId(int accountId, int productId) throws Exception {
        String queryStr = "SELECT * FROM " + tableName + " WHERE ACCOUNTID = ? AND PRODUCTID = ?";
        Cart cart = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, accountId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int cartID = rs.getInt("cartid");
                int productID = rs.getInt("productid");
                int productQty = rs.getInt("productqty");
                int accountID = rs.getInt("accountid");
                int createdBy = rs.getInt("createdby");
                String createdTime = rs.getString("createdtime");
                int updatedBy = rs.getInt("updatedby");
                String updatedTime = rs.getString("updatedtime");
                boolean isActive = rs.getBoolean("isactive");
                int deletedBy = rs.getInt("deletedby");
                String deletedTime = rs.getString("deletedtime");

                cart = new Cart(cartID, productID, productQty, accountID, createdBy, createdTime, updatedBy, updatedTime, isActive, deletedBy, deletedTime);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return cart;
    }

    public ArrayList<Cart> getAllRecord() throws Exception {
        String queryStr = "SELECT * FROM" + tableName;
        ArrayList<Cart> cartList = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int cartID = rs.getInt("cartid");
                int productID = rs.getInt("productid");
                int productQty = rs.getInt("productqty");
                int accountID = rs.getInt("accountid");
                int createdBy = rs.getInt("createdby");
                String createdTime = rs.getString("createdtime");
                int updatedBy = rs.getInt("updatedby");
                String updatedTime = rs.getString("updatedtime");
                boolean isActive = rs.getBoolean("isactive");
                int deletedBy = rs.getInt("deletedby");
                String deletedTime = rs.getString("deletedtime");

                Cart cart = new Cart(cartID, productID, productQty, accountID, createdBy, createdTime, updatedBy, updatedTime, isActive, deletedBy, deletedTime);
                cartList.add(cart);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return cartList;
    }

    public void addRecord(Cart cart) throws Exception {
        String insertStr = "INSERT INTO " + tableName + " (productid,productqty,accountid,createdby,createdtime,updatedby,updatedtime,isactive) VALUES (?,?,?,?,?,?,?,?)";

        try {
            stmt = conn.prepareStatement(insertStr);

            stmt.setInt(1, cart.getProductID());
            stmt.setInt(2, cart.getProductQty());
            stmt.setInt(3, cart.getAccountID());
            stmt.setInt(4, cart.getAccountID());
            stmt.setString(5, cart.getCreatedTime());
            stmt.setInt(6, cart.getAccountID());
            stmt.setString(7, cart.getUpdatedTime());
            stmt.setBoolean(8, cart.getIsActive());

            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public ArrayList<Cart> getRecordByAccountID(int accountId) throws Exception {
        if (accountId > 0) {
            String queryStr = "SELECT * FROM " + tableName + " WHERE ACCOUNTID = ?";
            ArrayList<Cart> cartList = new ArrayList<Cart>();
            try {
                stmt = conn.prepareStatement(queryStr);
                stmt.setInt(1, accountId);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    int cartID = rs.getInt("cartid");
                    int productID = rs.getInt("productid");
                    int productQty = rs.getInt("productqty");
                    int accountID = rs.getInt("accountid");
                    int createdBy = rs.getInt("createdby");
                    String createdTime = rs.getString("createdtime");
                    int updatedBy = rs.getInt("updatedby");
                    String updatedTime = rs.getString("updatedtime");
                    boolean isActive = rs.getBoolean("isactive");
                    int deletedBy = rs.getInt("deletedby");
                    String deletedTime = rs.getString("deletedtime");

                    Cart cart = new Cart(cartID, productID, productQty, accountID, createdBy, createdTime, updatedBy, updatedTime, isActive, deletedBy, deletedTime);
                    cartList.add(cart);
                }
                return cartList;
            } catch (SQLException ex) {
                throw ex;
            }
        } else {
            ArrayList<Cart> guestCarts = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader("guest_cart.txt"))) {
                String guestCartContent;
                while ((guestCartContent = reader.readLine()) != null) {
                    String[] parts = guestCartContent.split(",");
                    Cart carts = new Cart(Integer.parseInt(parts[0]), Integer.parseInt(parts[1]));
                    guestCarts.add(carts);
                }
                reader.close();
                boolean allProductExist = true;
                for (Cart c : guestCarts) {
                    Product product = productDA.getProductById(c.getProductID());
                    if (product == null) {
                        allProductExist = false;
                    }else if(!product.isActive()){
                        allProductExist = false;
                    }
                }
                if (!allProductExist) {
                    BufferedWriter writer = new BufferedWriter(new FileWriter("guest_cart.txt", false));
                    writer.write("");
                    writer.close();
                    guestCarts.clear();
                    BufferedReader readers = new BufferedReader(new FileReader("guest_cart.txt"));
                    String guestCartContents;
                    while ((guestCartContents = readers.readLine()) != null) {
                        String[] parts = guestCartContents.split(",");
                        Cart carts = new Cart(Integer.parseInt(parts[0]), Integer.parseInt(parts[1]));
                        guestCarts.add(carts);
                    }
                    reader.close();
                }
            } catch (FileNotFoundException ex) {
                BufferedWriter writer = new BufferedWriter(new FileWriter("guest_cart.txt", false));
                writer.write("");
                writer.close();
                BufferedReader reader = new BufferedReader(new FileReader("guest_cart.txt"));
                String guestCartContent;
                while ((guestCartContent = reader.readLine()) != null) {
                    String[] parts = guestCartContent.split(",");
                    Cart carts = new Cart(Integer.parseInt(parts[0]), Integer.parseInt(parts[1]));
                    guestCarts.add(carts);
                }
                reader.close();
            } catch (IOException ex) {
                throw ex;
            } finally {
                return guestCarts;
            }
        }
    }

    public void deleteRecord(int cartId) throws Exception {
        String deleteStr = "DELETE FROM " + tableName + " WHERE CARTID = ?";
        try {
            stmt = conn.prepareStatement(deleteStr);
            stmt.setInt(1, cartId);
            stmt.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        }
    }

    public void deleteRecordByAccountId(int accountId) throws Exception {
        String deleteStr = "DELETE FROM " + tableName + " WHERE ACCOUNTID = ?";
        try {
            stmt = conn.prepareStatement(deleteStr);
            stmt.setInt(1, accountId);
            stmt.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        }
    }

    public void editRecord(Cart cart) throws Exception {
        String updateStr = "UPDATE " + tableName + " SET productid = ?, productqty = ?, accountid = ?, createdby = ?, createdtime = ?, updatedby = ?, updatedtime = ?, isactive = ?, deletedby = ?, deletedtime = ? WHERE cartid = ?";

        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String created_date = currentDateTime.format(formatter);
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1, cart.getProductID());
            stmt.setInt(2, cart.getProductQty());
            stmt.setInt(3, cart.getAccountID());
            stmt.setInt(4, cart.getCreatedBy());
            stmt.setString(5, cart.getCreatedTime());
            stmt.setInt(6, cart.getUpdatedBy());
            stmt.setString(7, created_date);
            stmt.setBoolean(8, true);
            stmt.setInt(9, cart.getDeletedBy());
            stmt.setString(10, cart.getDeletedTime());
            stmt.setInt(11, cart.getCartID());
            stmt.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        }
    }

    public double totalPrice(ArrayList<Cart> cart) throws Exception {
        try {
            double totalPrice = 0;
            for (Cart c : cart) {
                Product product = productDA.getProductById(c.getProductID());
                if (product != null) {
                    totalPrice += product.getUnitPrice() * c.getProductQty();
                }
            }
            return totalPrice;
        } catch (Exception ex) {
            throw ex;
        }
    }

    private void createConnection() throws Exception {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
            System.out.println("***TRACE: Connection established.");
        } catch (SQLException ex) {
            throw ex;
        }
    }
}
