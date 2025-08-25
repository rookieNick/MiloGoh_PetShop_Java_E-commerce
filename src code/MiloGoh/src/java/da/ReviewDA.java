package da;

import domain.Review;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ReviewDA {

    private String host = "jdbc:derby://localhost:1527/milogoh";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Review";
    private Connection conn;
    private PreparedStatement stmt;

    public ReviewDA() {
        createConnection();
    }

    public Review getReviewById(int reviewId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE REVIEWID = ?";
        Review review = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, reviewId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve all column values from ResultSet
                double rate = rs.getDouble("RATE");
                String content = rs.getString("CONTENT");
                int accountId = rs.getInt("ACCOUNTID");
                String createdate = rs.getString("CREATEDATE");
                String updatedtime = rs.getString("UPDATEDTIME");
                boolean isactive = rs.getBoolean("ISACTIVE");
                int productId = rs.getInt("PRODUCTID");

                // Create Review object with retrieved values
                review = new Review(reviewId);
                review.setRate(rate);
                review.setContent(content);
                review.setAccountid(accountId);
                review.setCreatedate(createdate);
                review.setUpdatedtime(updatedtime);
                review.setIsactive(isactive);
                review.setProductID(productId);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return review;
    }

    public ArrayList<Review> getAllReviews(int prodId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE PRODUCTID = ?";
        ArrayList<Review> reviews = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1,prodId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Retrieve all column values from ResultSet and create Review objects
                int reviewId = rs.getInt("REVIEWID");
                double rate = rs.getDouble("RATE");
                String content = rs.getString("CONTENT");
                int accountId = rs.getInt("ACCOUNTID");
                String createdate = rs.getString("CREATEDATE");
                String updatedtime = rs.getString("UPDATEDTIME");
                boolean isactive = rs.getBoolean("ISACTIVE");
                int productId = rs.getInt("PRODUCTID");

                // Create Review object with retrieved values
                Review review = new Review(reviewId);
                review.setRate(rate);
                review.setContent(content);
                review.setAccountid(accountId);
                review.setCreatedate(createdate);
                review.setUpdatedtime(updatedtime);
                review.setIsactive(isactive);
                review.setProductID(productId);

                // Add Review object to the ArrayList
                reviews.add(review);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return reviews;
    }

    public void addReview(Review review) {
        String insertStr = "INSERT INTO " + tableName + " (RATE, CONTENT, ACCOUNTID, CREATEDATE, UPDATEDTIME, ISACTIVE, PRODUCTID) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String created_date = currentDateTime.format(formatter);

        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setDouble(1, review.getRate());
            stmt.setString(2, review.getContent());
            stmt.setInt(3, review.getAccountid());
            stmt.setString(4, created_date);
            stmt.setString(5, created_date);
            stmt.setBoolean(6, true);
            stmt.setInt(7, review.getProductID());

            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateReview(Review review) {
        String updateStr = "UPDATE " + tableName + " SET RATE=?, CONTENT=?, ACCOUNTID=?, CREATEDATE=?, UPDATEDTIME=?, ISACTIVE=?, PRODUCTID=? "
                + "WHERE REVIEWID=?";
 
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String Updated_date = currentDateTime.format(formatter);
        
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setDouble(1, review.getRate());
            stmt.setString(2, review.getContent());
            stmt.setInt(3, review.getAccountid());
            stmt.setString(4, review.getCreatedate());
            stmt.setString(5, Updated_date);
            stmt.setBoolean(6, true);
            stmt.setInt(7, review.getProductID());
            stmt.setInt(8, review.getReviewid());

            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    public void deleteReview(int reviewId) {
        String deleteStr = "DELETE FROM " + tableName + " WHERE REVIEWID=?";
        try {
            stmt = conn.prepareStatement(deleteStr);
            stmt.setInt(1, reviewId);
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
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
