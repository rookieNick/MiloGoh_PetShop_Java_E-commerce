package servlet;

import control.MaintainAccountControl;
import domain.Account;
import Exception.Password;
import Exception.InvalidPasswordException;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

@WebServlet("/StaffProfileServlet")
public class StaffProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Retrieve form data
        int accountID = Integer.parseInt(request.getParameter("accountID"));
        String ic = request.getParameter("ic");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gmail = request.getParameter("gmail");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String birthday = request.getParameter("birthday");
        String password = request.getParameter("password");
        String status = "Active";
        String created_date = request.getParameter("created_date");
        String updated_date = request.getParameter("updated_date");
        String position = request.getParameter("position");
        double wallet = 0.0;
        
        String created_by = request.getParameter("created_by");
        String updated_by = request.getParameter("updated_by");


        //validation start---------------------------------
        Boolean isInvalid = false;
        String errorMsgProfile = "";

        //password
        try {
            Password pw = new Password(password);
        } catch (InvalidPasswordException ex) {
            isInvalid = true;
            errorMsgProfile += "Invalid password format\n";
        }

        //ic
        if (ic.length() != 12) {
            isInvalid = true;
            errorMsgProfile += "IC length must be 12\n";
        }

        for (int i = 0; i < ic.length(); i++) {
            if (!Character.isDigit(ic.charAt(i))) {
                isInvalid = true;
                errorMsgProfile += "IC must only contain number\n";
            }
        }

        //name 
        if (!firstName.matches("[a-zA-Z ]+")) {
            isInvalid = true;
            errorMsgProfile += "First name can only contain alphabets and spaces\n";
        }

        // Validate last name (only alphabetic characters)
        if (!lastName.matches("[a-zA-Z ]+")) {
            isInvalid = true;
            errorMsgProfile += "Last name can only contain alphabets and spaces\n";
        }

        //phone no
        if (!phoneNumber.matches("[0-9]+")) {
            isInvalid = true;
            errorMsgProfile += "Phone number can only contain numbers\n";
        }

        // Parse the provided birthday string into a LocalDate object
        LocalDate birthdayDate = null;
        try {
            birthdayDate = LocalDate.parse(birthday, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch (DateTimeParseException e) {
            isInvalid = true;
            errorMsgProfile += "Invalid birthday format\n";
        }

        // Check if the birthday is before today
        if (birthdayDate != null && birthdayDate.isAfter(LocalDate.now())) {
            isInvalid = true;
            errorMsgProfile += "Birthday must be before today\n";
        }
        
        //CHECK DUPLICATE IN DATABASE (ic,username,email,phone)
        MaintainAccountControl accountControl = new MaintainAccountControl();
        ArrayList<Account> accountList = accountControl.selectAllAccuntFromStatus("Active");
        ArrayList<Account> accountList2 = accountControl.selectAllAccuntFromStatus("Unset");
        accountList.addAll(accountList2);   //combine 2 array, dont check Deleted account
        
        for (Account account: accountList) {
            int checkAccountID = account.getAccountID();
            if(accountID != checkAccountID){  //duplicate Check but skip same acc (user can update using same imformation)
                    if (account.getIc() != null && account.getIc().equals(ic)) {
                    isInvalid = true;
                    errorMsgProfile += "IC already exists\n";
                }

                if (account.getUsername()!= null && account.getUsername().equals(username)) {
                    isInvalid = true;
                    errorMsgProfile += "Username already exists\n";
                }

                if (account.getPhoneNumber()!= null && account.getPhoneNumber().equals(phoneNumber)) {
                    isInvalid = true;
                    errorMsgProfile += "Phone number already exists\n";
                }

                if (account.getGmail()!= null && account.getGmail().equals(gmail)) {
                    isInvalid = true;
                    errorMsgProfile += "Email already exists\n";
                }
            }
        }
        //validation end---------------------------

        Account account = new Account(accountID, firstName, lastName, password, gmail, phoneNumber, gender, address, ic, username, birthday, position, created_by, created_date, updated_by, updated_date, status, wallet);

        if (isInvalid == false) {

            
                accountControl = new MaintainAccountControl();
                account.setUpdated_by(username);    //get the new name
                accountControl.editRecord(account);

                //retrieve new account (updated ver)
                account = accountControl.selectRecord(account.getAccountID() + "");
                request.getSession().setAttribute("account", account);
                request.getSession().setAttribute("staffAccount", account);
                // Redirect to a success page
                response.sendRedirect("jsp/Manager/staffEditProfile.jsp?success=1");


        } else {
            // Set account object as request attribute
            request.getSession().setAttribute("accountReturn", account);
            request.getSession().setAttribute("errorMsgProfile", errorMsgProfile);
            //request.setAttribute("account", account);
            //RequestDispatcher requestDispatcher = request.getRequestDispatcher("jsp/signup.jsp");

            //requestDispatcher.forward(request, response);
            response.sendRedirect("jsp/Manager/staffEditProfile.jsp?error=1");
        }
        

    }
}
