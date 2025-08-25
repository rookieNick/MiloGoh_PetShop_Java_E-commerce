package da;

import domain.Image;
import java.sql.*;
import java.util.ArrayList;

public class ImageDA {

    private String host = "jdbc:derby://localhost:1527/milogoh"; // Update with your database connection details
    private String user = "nbuser"; // Update with your database username
    private String password = "nbuser"; // Update with your database password
    private String tableName = "Image"; // Update with your database table name
    private Connection conn;
    private PreparedStatement stmt;

    public ImageDA() {
        createConnection();
    }

    public Image getImageById(int imageId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        Image image = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, imageId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve all column values from ResultSet
                int id = rs.getInt("id");
                byte[] image1 = rs.getBytes("image1");
                byte[] image2 = rs.getBytes("image2");
                byte[] image3 = rs.getBytes("image3");
                byte[] image4 = rs.getBytes("image4");
                byte[] image5 = rs.getBytes("image5");
                byte[] image6 = rs.getBytes("image6");
                byte[] image7 = rs.getBytes("image7");
                byte[] image8 = rs.getBytes("image8");
                byte[] image9 = rs.getBytes("image9");
                byte[] image10 = rs.getBytes("image10");
                
                // Add more fields for image3, image4, ..., image10 as needed

                // Create Image object with retrieved values
                image = new Image(id, image1, image2,image3,image4,image5,image6,image7,image8,image9,image10);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return image;
    }
    // Method to get all images from the database
    public ArrayList<byte[]> getAllImagesById(int imageId) {
        ArrayList<byte[]> allImages = new ArrayList<>();
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, imageId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Add all images to the ArrayList
                allImages.add(rs.getBytes("image1"));
                allImages.add(rs.getBytes("image2"));
                allImages.add(rs.getBytes("image3"));
                allImages.add(rs.getBytes("image4"));
                allImages.add(rs.getBytes("image5"));
                allImages.add(rs.getBytes("image6"));
                allImages.add(rs.getBytes("image7"));
                allImages.add(rs.getBytes("image8"));
                allImages.add(rs.getBytes("image9"));
                allImages.add(rs.getBytes("image10"));

                
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return allImages;
    }

    // Method to add a new image record
    public void addImage(Image image) {
    String insertStr = "INSERT INTO " + tableName + " (image1, image2, image3, image4, image5, image6, image7, image8, image9, image10,id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
    try {
        stmt = conn.prepareStatement(insertStr);

        // Set parameters for the prepared statement
        stmt.setBytes(1, image.getImage1());
        stmt.setBytes(2, image.getImage2());
        stmt.setBytes(3, image.getImage3());
        stmt.setBytes(4, image.getImage4());
        stmt.setBytes(5, image.getImage5());
        stmt.setBytes(6, image.getImage6());
        stmt.setBytes(7, image.getImage7());
        stmt.setBytes(8, image.getImage8());
        stmt.setBytes(9, image.getImage9());
        stmt.setBytes(10, image.getImage10());
        stmt.setInt(11, image.getId());
        // Set parameters for more images (image11, image12, ..., imageN) as needed

        // Execute the prepared statement
        stmt.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}


    // Method to update an existing image record
    public void updateImage(Image image) {
    String updateStr = "UPDATE " + tableName + " SET image1 = ?, image2 = ?, image3 = ?, image4 = ?, image5 = ?, image6 = ?, image7 = ?, image8 = ?, image9 = ?, image10 = ? WHERE id = ?";
    try {
        stmt = conn.prepareStatement(updateStr);

        // Set parameters for the prepared statement
        stmt.setBytes(1, image.getImage1());
        stmt.setBytes(2, image.getImage2());
        stmt.setBytes(3, image.getImage3());
        stmt.setBytes(4, image.getImage4());
        stmt.setBytes(5, image.getImage5());
        stmt.setBytes(6, image.getImage6());
        stmt.setBytes(7, image.getImage7());
        stmt.setBytes(8, image.getImage8());
        stmt.setBytes(9, image.getImage9());
        stmt.setBytes(10, image.getImage10());
        // Set parameters for more images (image11, image12, ..., imageN) as needed
        stmt.setInt(11, image.getId());

        // Execute the prepared statement
        stmt.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    
    
}

    public void deleteImage(Image image) {
    String deleteStr = "DELETE FROM " + tableName + " WHERE id = ?";
    try {
        stmt = conn.prepareStatement(deleteStr);

        // Set the parameter for the prepared statement
        stmt.setInt(1, image.getId());

        // Execute the prepared statement
        stmt.executeUpdate();
    } catch (SQLException ex) {
        // Handle SQLException appropriately (log or throw)
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