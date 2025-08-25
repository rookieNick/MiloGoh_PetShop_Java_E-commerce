package da;

import domain.Account;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class AccountDA {

    private String host = "jdbc:derby://localhost:1527/milogoh";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Account";
    private Connection conn;
    private PreparedStatement stmt;

    public AccountDA() {
        createConnection();
    }

    public Account loginValidation(String username, String password) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE username = ? AND password = ? AND status = 'Active'";
        Account account = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve all column values from ResultSet
                int accountID = rs.getInt("accountID");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String passwordFromDB = rs.getString("password");
                String gmail = rs.getString("gmail");
                String phoneNumber = rs.getString("phoneNumber");
                String gender = rs.getString("gender");
                String address = rs.getString("address");
                String ic = rs.getString("ic");
                String usernameFromDB = rs.getString("username");
                String birthday = rs.getString("birthday");
                String position = rs.getString("position");
                String created_by = rs.getString("created_by");
                String created_date = rs.getString("created_date");
                String updated_by = rs.getString("updated_by");
                String updated_date = rs.getString("updated_date");
                String status = rs.getString("status");
                double wallet = rs.getDouble("wallet");

                // Create Account object with retrieved values
                account = new Account(accountID, firstName, lastName, passwordFromDB, gmail, phoneNumber, gender, address, ic, usernameFromDB, birthday, position, created_by, created_date, updated_by, updated_date, status, wallet);
            }
        } catch (SQLException ex) {
            
        }
        return account;
    }
    
    public Account newStaffLoginValidation(String staffId, String password) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE accountID = ? AND password = ? AND status = 'Unset'";
        Account account = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, staffId);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve all column values from ResultSet
                int accountID = rs.getInt("accountID");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String passwordFromDB = rs.getString("password");
                String gmail = rs.getString("gmail");
                String phoneNumber = rs.getString("phoneNumber");
                String gender = rs.getString("gender");
                String address = rs.getString("address");
                String ic = rs.getString("ic");
                String usernameFromDB = rs.getString("username");
                String birthday = rs.getString("birthday");
                String position = rs.getString("position");
                String created_by = rs.getString("created_by");
                String created_date = rs.getString("created_date");
                String updated_by = rs.getString("updated_by");
                String updated_date = rs.getString("updated_date");
                String status = rs.getString("status");
                double wallet = rs.getDouble("wallet");

                // Create Account object with retrieved values
                account = new Account(accountID, firstName, lastName, passwordFromDB, gmail, phoneNumber, gender, address, ic, usernameFromDB, birthday, position, created_by, created_date, updated_by, updated_date, status, wallet);
            }
        } catch (SQLException ex) {
            
        }
        return account;
    }

    public Account getRecord(String inputAccountID) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE accountID = ?";
        Account account = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, inputAccountID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve all column values from ResultSet
                int accountID = rs.getInt("accountID");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String passwordFromDB = rs.getString("password");
                String gmail = rs.getString("gmail");
                String phoneNumber = rs.getString("phoneNumber");
                String gender = rs.getString("gender");
                String address = rs.getString("address");
                String ic = rs.getString("ic");
                String usernameFromDB = rs.getString("username");
                String birthday = rs.getString("birthday");
                String position = rs.getString("position");
                String created_by = rs.getString("created_by");
                String created_date = rs.getString("created_date");
                String updated_by = rs.getString("updated_by");
                String updated_date = rs.getString("updated_date");
                String status = rs.getString("status");
                double wallet = rs.getDouble("wallet");

                // Create Account object with retrieved values
                account = new Account(accountID, firstName, lastName, passwordFromDB, gmail, phoneNumber, gender, address, ic, usernameFromDB, birthday, position, created_by, created_date, updated_by, updated_date, status, wallet);
            }
        } catch (SQLException ex) {
            
        }
        return account;
    }

    public ArrayList<Account> getAllCertainRecords(String pst) {
    String queryStr = "SELECT * FROM " + tableName ;
    if (!pst.equals("")) {
        queryStr += " WHERE position = ? ";
    }
    queryStr += " ORDER BY accountID ASC" ;
    ArrayList<Account> customerRecords = new ArrayList<>();
    
    try {
        stmt = conn.prepareStatement(queryStr);
        
        if (!pst.equals("")) {
            stmt.setString(1, pst);
        }
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            // Retrieve all column values from ResultSet
            int accountID = rs.getInt("accountID");
            String firstName = rs.getString("firstName");
            String lastName = rs.getString("lastName");
            String passwordFromDB = rs.getString("password");
            String gmail = rs.getString("gmail");
            String phoneNumber = rs.getString("phoneNumber");
            String gender = rs.getString("gender");
            String address = rs.getString("address");
            String ic = rs.getString("ic");
            String usernameFromDB = rs.getString("username");
            String birthday = rs.getString("birthday");
            String position = rs.getString("position");
            String created_by = rs.getString("created_by");
            String created_date = rs.getString("created_date");
            String updated_by = rs.getString("updated_by");
            String updated_date = rs.getString("updated_date");
            String status = rs.getString("status");
            double wallet = rs.getDouble("wallet");

            // Create Account object with retrieved values
            Account account = new Account(accountID, firstName, lastName, passwordFromDB, gmail, phoneNumber, gender, address, ic, usernameFromDB, birthday, position, created_by, created_date, updated_by, updated_date, status, wallet);
            
            // Add Account object to the ArrayList
            customerRecords.add(account);
        }
    } catch (SQLException ex) {
        
    }
    
    return customerRecords;
}
    
    public ArrayList<Account> getAllAccountFromStatus(String inputStatus) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE status = ?";
        ArrayList<Account> customerRecords = new ArrayList<>();
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, inputStatus);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Retrieve all column values from ResultSet
                int accountID = rs.getInt("accountID");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String passwordFromDB = rs.getString("password");
                String gmail = rs.getString("gmail");
                String phoneNumber = rs.getString("phoneNumber");
                String gender = rs.getString("gender");
                String address = rs.getString("address");
                String ic = rs.getString("ic");
                String usernameFromDB = rs.getString("username");
                String birthday = rs.getString("birthday");
                String position = rs.getString("position");
                String created_by = rs.getString("created_by");
                String created_date = rs.getString("created_date");
                String updated_by = rs.getString("updated_by");
                String updated_date = rs.getString("updated_date");
                String status = rs.getString("status");
                double wallet = rs.getDouble("wallet");

                // Create Account object with retrieved values
                Account account = new Account(accountID, firstName, lastName, passwordFromDB, gmail, phoneNumber, gender, address, ic, usernameFromDB, birthday, position, created_by, created_date, updated_by, updated_date, status, wallet);
                
                // Add Account object to the ArrayList
                customerRecords.add(account);
            }
        } catch (SQLException ex) {
            
        }
        return customerRecords;
    }

    public Account findAccountFromGmail(String inputGmail) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE gmail = ?";
        Account account = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, inputGmail);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve all column values from ResultSet
                int accountID = rs.getInt("accountID");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String passwordFromDB = rs.getString("password");
                String gmail = rs.getString("gmail");
                String phoneNumber = rs.getString("phoneNumber");
                String gender = rs.getString("gender");
                String address = rs.getString("address");
                String ic = rs.getString("ic");
                String usernameFromDB = rs.getString("username");
                String birthday = rs.getString("birthday");
                String position = rs.getString("position");
                String created_by = rs.getString("created_by");
                String created_date = rs.getString("created_date");
                String updated_by = rs.getString("updated_by");
                String updated_date = rs.getString("updated_date");
                String status = rs.getString("status");
                double wallet = rs.getDouble("wallet");

                // Create Account object with retrieved values
                account = new Account(accountID, firstName, lastName, passwordFromDB, gmail, phoneNumber, gender, address, ic, usernameFromDB, birthday, position, created_by, created_date, updated_by, updated_date, status, wallet);
            }
        } catch (SQLException ex) {
            
        }
        return account;
    }
    
    
    
    public void addRecord(Account account) {
        String insertStr = "INSERT INTO " + tableName + " (firstName, lastName, password, gmail, phoneNumber, gender, address, ic, username, birthday, position, status, wallet,created_date, updated_date, created_By, updated_by) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String created_date = currentDateTime.format(formatter);

        try {
            stmt = conn.prepareStatement(insertStr);

            stmt.setString(1, account.getFirstName());
            stmt.setString(2, account.getLastName());
            stmt.setString(3, account.getPassword());
            stmt.setString(4, account.getGmail());
            stmt.setString(5, account.getPhoneNumber());
            stmt.setString(6, account.getGender());
            stmt.setString(7, account.getAddress());
            stmt.setString(8, account.getIc());
            stmt.setString(9, account.getUsername());
            stmt.setString(10, account.getBirthday());
            stmt.setString(11, account.getPosition());
            stmt.setString(12, account.getStatus());
            stmt.setDouble(13, account.getWallet());
            stmt.setString(14, created_date);
            stmt.setString(15, created_date);
            stmt.setString(16, account.getCreated_by());
            stmt.setString(17, account.getUpdated_by());

            stmt.executeUpdate();

        } catch (SQLException ex) {
            
        }
    }

    public void editRecord(Account account) {
        String editStr = "UPDATE " + tableName + " SET firstName = ?, lastName = ?, password = ?, gmail = ?, phoneNumber = ?, gender = ?, address = ?, ic = ?, username = ?, birthday = ?, position = ?, created_by = ?, created_date = ?, updated_by = ?, updated_date = ?, status = ?, wallet = ? WHERE accountID = ?";

        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String updated_date = currentDateTime.format(formatter);
        try {
            stmt = conn.prepareStatement(editStr);
            stmt.setString(1, account.getFirstName());
            stmt.setString(2, account.getLastName());
            stmt.setString(3, account.getPassword());
            stmt.setString(4, account.getGmail());
            stmt.setString(5, account.getPhoneNumber());
            stmt.setString(6, account.getGender());
            stmt.setString(7, account.getAddress());
            stmt.setString(8, account.getIc());
            stmt.setString(9, account.getUsername());
            stmt.setString(10, account.getBirthday());
            stmt.setString(11, account.getPosition());
            stmt.setString(12, account.getCreated_by());
            stmt.setString(13, account.getCreated_date());
            stmt.setString(14, account.getUpdated_by());
            stmt.setString(15, updated_date);
            stmt.setString(16, account.getStatus());
            stmt.setDouble(17, account.getWallet());
            stmt.setInt(18, account.getAccountID());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            
        }
    }

    public void deleteRecord(Account account) {
        String deleteStr = "DELETE FROM " + tableName + " WHERE accountID = ?";
        try {
            stmt = conn.prepareStatement(deleteStr);
            stmt.setInt(1, account.getAccountID());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            
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
            
        }
    }

}
