
package domain;


public class Account {
    private int accountID;
    private String firstName;
    private String lastName;
    private String password;
    private String gmail;
    private String phoneNumber;
    private String gender;
    private String address;
    private String ic;
    private String username;
    private String birthday;
    private String position;
    private String created_by;
    private String created_date;
    private String updated_by;
    private String updated_date;
    private String status;
    private double wallet = 0.0;

    // Constructor
    public Account() {
        // Default constructor
    }
    
    public Account(int accountID,String position){
        this.accountID = accountID;
        this.position = position;
    }
    
    public Account(int accountID, String firstName, String lastName, String password, String gmail, String phoneNumber, String gender, String address, String ic, String username, String birthday) {
        this.accountID = accountID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.gmail = gmail;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.address = address;
        this.ic = ic;
        this.username = username;
        this.birthday = birthday;
        //this.position = "";
    }
    
        public Account(int accountID, String firstName, String lastName, String password, String gmail, String phoneNumber, String gender, String address, String ic, String username, String birthday, String position) {
        this.accountID = accountID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.gmail = gmail;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.address = address;
        this.ic = ic;
        this.username = username;
        this.birthday = birthday;
        this.position = position;
    }
        
    // Full constructor
    public Account(int accountID, String firstName, String lastName, String password, String gmail, String phoneNumber, String gender, String address, String ic, String username, String birthday, String position, String created_by, String created_date, String updated_by, String updated_date, String status, double wallet) {
        this.accountID = accountID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.gmail = gmail;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.address = address;
        this.ic = ic;
        this.username = username;
        this.birthday = birthday;
        this.position = position;
        this.created_by = created_by;
        this.created_date = created_date;
        this.updated_by = updated_by;
        this.updated_date = updated_date;
        this.status = status;
        this.wallet = wallet;
    }

    // Getters and setters
    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGmail() {
        return gmail;
    }

    public void setGmail(String gmail) {
        this.gmail = gmail;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getIc() {
        return ic;
    }

    public void setIc(String ic) {
        this.ic = ic;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }
    
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
    
    public String getCreated_by() {
        return created_by;
    }

    public void setCreated_by(String created_by) {
        this.created_by = created_by;
    }

    public String getCreated_date() {
        return created_date;
    }

    public void setCreated_date(String created_date) {
        this.created_date = created_date;
    }

    public String getUpdated_by() {
        return updated_by;
    }

    public void setUpdated_by(String updated_by) {
        this.updated_by = updated_by;
    }

    public String getUpdated_date() {
        return updated_date;
    }

    public void setUpdated_date(String updated_date) {
        this.updated_date = updated_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public Double getWallet() {
        return wallet;
    }

    public void setWallet(Double wallet) {
        this.wallet = wallet;
    }
}
