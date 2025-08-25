package da;

import domain.Image;
import domain.Product;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class ProductDA {

    private String host = "jdbc:derby://localhost:1527/milogoh";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Product";
    private Connection conn;
    private PreparedStatement stmt;

    private ImageDA imageDA;

    public ProductDA() {
        createConnection();

        imageDA = new ImageDA();
    }

    public Product getProductById(int productId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        Product product = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve all column values from ResultSet
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                double unitPrice = rs.getDouble("unitprice");
                int stockQty = rs.getInt("stockQty");
                String type = rs.getString("type");
                String createdDate = rs.getString("createddate");
                String updatedDate = rs.getString("updatedDate");
                String updatedBy = rs.getString("updatedby");
                String createdBy = rs.getString("createdby");
                boolean isActive = rs.getBoolean("isactive");
                String category = rs.getString("category");
                int imageId = rs.getInt("image");

                Image image = imageDA.getImageById(imageId);

                // Create Product object with retrieved values
                product = new Product(id, name, description, unitPrice, type, createdDate, updatedDate, updatedBy, createdBy, isActive, category, image, stockQty);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return product;
    }

    public ArrayList<Product> getAllProducts(String searchBy, String categ, String active) {
        String queryStr = "SELECT * FROM " + tableName;
        String condition = "";
       

        // Construct WHERE clause based on provided parameters
        if (searchBy != null && !searchBy.isEmpty()) {
            condition += "LOWER(name) LIKE ?";
        }
        if (categ != null && !categ.isEmpty()) {
            if (!condition.isEmpty()) {
                condition += " AND ";
            }
            condition += "category = ?";
        }

        if (!condition.isEmpty()) {
            queryStr += " WHERE " + condition;
        }
        queryStr += " ORDER BY id ASC";

        ArrayList<Product> products = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(queryStr);
            int parameterIndex = 1; // Start index for setting parameters

            // Set parameters based on search criteria
            if (searchBy != null && !searchBy.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + searchBy + "%");
            }
            if (categ != null && !categ.isEmpty()) {
                stmt.setString(parameterIndex++, categ);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Retrieve all column values from ResultSet and create Product objects
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                double unitPrice = rs.getDouble("unitprice");
                int stockQty = rs.getInt("stockQty");
                String type = rs.getString("type");
                String createdDate = rs.getString("createddate");
                String updatedDate = rs.getString("updatedDate");
                String updatedBy = rs.getString("updatedby");
                String createdBy = rs.getString("createdby");
                boolean isActive = rs.getBoolean("isactive");
                String category = rs.getString("category");
                int imageId = rs.getInt("image");

                Image image = imageDA.getImageById(imageId);
                if (active.equals("")) {
                    if (isActive) {
                        // Create Product object with retrieved values
                        Product product = new Product(id, name, description, unitPrice, type, createdDate, updatedDate, updatedBy, createdBy, isActive, category, image, stockQty);

                        // Add Product object to the ArrayList
                        products.add(product);
                    }
                } else {
                    // Create Product object with retrieved values
                    Product product = new Product(id, name, description, unitPrice, type, createdDate, updatedDate, updatedBy, createdBy, isActive, category, image, stockQty);

                    // Add Product object to the ArrayList
                    products.add(product);
                }

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return products;
    }

    public ArrayList<Product> getAllProductsFromIsActive(String active) {
        String queryStr = "SELECT * FROM " + tableName;
        String condition = "";

        // Construct WHERE clause based on provided parameters
        if (active != null && !active.isEmpty()) {
            condition += "isActive = ?";
        }

        if (!condition.isEmpty()) {
            queryStr += " WHERE " + condition;
        }
        queryStr += " ORDER BY id ASC";

        ArrayList<Product> products = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(queryStr);
            int parameterIndex = 1; // Start index for setting parameters

            // Set parameters based on search criteria
            if (active != null && !active.isEmpty()) {
                stmt.setBoolean(parameterIndex++, Boolean.parseBoolean(active));
            }
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Retrieve all column values from ResultSet and create Product objects
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                double unitPrice = rs.getDouble("unitprice");
                int stockQty = rs.getInt("stockQty");
                String type = rs.getString("type");
                String createdDate = rs.getString("createddate");
                String updatedDate = rs.getString("updatedDate");
                String updatedBy = rs.getString("updatedby");
                String createdBy = rs.getString("createdby");
                boolean isActive = rs.getBoolean("isactive");
                String category = rs.getString("category");
                int imageId = rs.getInt("image");

                Image image = imageDA.getImageById(imageId);

                // Create Product object with retrieved values
                Product product = new Product(id, name, description, unitPrice, type, createdDate, updatedDate, updatedBy, createdBy, isActive, category, image, stockQty);

                // Add Product object to the ArrayList
                products.add(product);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return products;
    }

    public void addProduct(Product product) {
        String insertStr = "INSERT INTO " + tableName + " (name, description, unitprice, type, createddate, updatedDate, updatedby, createdby, isactive, category, image, stockQty) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";

        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String createdDate = currentDateTime.format(formatter);

        try {
            stmt = conn.prepareStatement(insertStr);

            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getUnitPrice());
            stmt.setString(4, product.getType());
            stmt.setString(5, createdDate);
            stmt.setString(6, createdDate); // Assuming created date and update time are the same at creation
            stmt.setString(7, product.getUpdatedBy()); // Assuming the person who created is also the updater
            stmt.setString(8, product.getCreatedBy());
            stmt.setBoolean(9, product.isActive());
            stmt.setString(10, product.getCategory());
            stmt.setInt(11, product.getImage().getId());
            stmt.setInt(12, product.getStockQty());

            stmt.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateProduct(Product product) {
        String updateStr = "UPDATE " + tableName + " SET name = ?, description = ?, unitprice = ?, type = ?, updatedDate = ?, updatedby = ?, isactive = ?, category = ?, image = ?, stockQty = ? WHERE id = ?";

        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String updatedDate = currentDateTime.format(formatter);

        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getUnitPrice());
            stmt.setString(4, product.getType());
            stmt.setString(5, updatedDate);
            stmt.setString(6, product.getUpdatedBy());
            stmt.setBoolean(7, product.isActive());
            stmt.setString(8, product.getCategory());
            stmt.setInt(9, product.getImage().getId());
            stmt.setInt(10, product.getStockQty());
            stmt.setInt(11, product.getId());

            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteProduct(Product product) {
        String deleteStr = "DELETE FROM " + tableName + " WHERE id = ?";
        try {
            stmt = conn.prepareStatement(deleteStr);
            stmt.setInt(1, product.getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    private void createConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
            System.out.println("***TRACE: Connection established.");
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    private void shutDown() {
        if (conn != null)
            try {
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
