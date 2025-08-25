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

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gmail = request.getParameter("gmail");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String ic = request.getParameter("ic");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String birthday = request.getParameter("birthday");
        String position = "Customer";
        
        String created_by = request.getParameter("username");
        String updated_by = request.getParameter("username");

        Boolean isInvalid = false;
        String errorMsg = "";

        //password
        try {
            Password pw = new Password(password);
        } catch (InvalidPasswordException ex) {
            isInvalid = true;
            errorMsg += "Invalid password format\n";
        }

        if (!(password.equals(confirmPassword))) {
            isInvalid = true;
            errorMsg += "Password not match\n";
        }

        //ic
        if (ic.length() != 12) {
            isInvalid = true;
            errorMsg += "IC length must be 12\n";
        }

        for (int i = 0; i < ic.length(); i++) {
            if (!Character.isDigit(ic.charAt(i))) {
                isInvalid = true;
                errorMsg += "IC must only contain number\n";
            }
        }

        //name 
        if (!firstName.matches("[a-zA-Z ]+")) {
            isInvalid = true;
            errorMsg += "First name can only contain alphabets and spaces\n";
        }

        // Validate last name (only alphabetic characters)
        if (!lastName.matches("[a-zA-Z ]+")) {
            isInvalid = true;
            errorMsg += "Last name can only contain alphabets and spaces\n";
        }

        //phone no
        if (!phoneNumber.matches("[0-9]+")) {
            isInvalid = true;
            errorMsg += "Phone number can only contain numbers\n";
        }

        //birthday
        try {
            LocalDate parsedBirthday = LocalDate.parse(birthday, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            LocalDate today = LocalDate.now();

            // Check if the parsed date is in the past
            if (parsedBirthday.isAfter(today)) {
                isInvalid = true;
                errorMsg += "Birthday must be set before today\n";
            }
        } catch (DateTimeParseException ex) {
            isInvalid = true;
            errorMsg += "Invalid date format\n";
        }
        
        //CHECK DUPLICATE IN DATABASE (ic,username,email,phone)
        MaintainAccountControl accountControl = new MaintainAccountControl();
        ArrayList<Account> accountList = accountControl.selectAllAccuntFromStatus("Active");
        ArrayList<Account> accountList2 = accountControl.selectAllAccuntFromStatus("Unset");
        accountList.addAll(accountList2);   //combine 2 array, dont check Deleted account
        
        for (Account account : accountList) {
            if (account.getIc() != null && account.getIc().equals(ic)) {
                isInvalid = true;
                errorMsg += "IC already exists\n";
            }

            if (account.getUsername() != null && account.getUsername().equals(username)) {
                isInvalid = true;
                errorMsg += "Username already exists\n";
            }

            if (account.getPhoneNumber() != null && account.getPhoneNumber().equals(phoneNumber)) {
                isInvalid = true;
                errorMsg += "Phone number already exists\n";
            }

            if (account.getGmail() != null && account.getGmail().equals(gmail)) {
                isInvalid = true;
                errorMsg += "Email already exists\n";
            }
        }

        // Create an Account object 
        Account account = new Account();
        account.setFirstName(firstName);
        account.setLastName(lastName);
        account.setGmail(gmail);
        account.setPhoneNumber(phoneNumber);
        account.setGender(gender);
        account.setAddress(address);
        account.setIc(ic);
        account.setUsername(username);
        account.setPassword(password);
        account.setBirthday(birthday);
        account.setPosition(position);
        account.setStatus("Active");
        account.setCreated_by(created_by);
        account.setUpdated_by(updated_by);

        if (isInvalid == false) {
            // Call the addRecord method in MaintainAccountControl to add the new account
            accountControl.addRecord(account);

            // Redirect to a success page
            response.sendRedirect("jsp/login.jsp?success=1");
        } else {
            // Set account object as request attribute
            request.getSession().setAttribute("account", account);
            request.getSession().setAttribute("errorMsg", errorMsg);
            //request.setAttribute("account", account);
            //RequestDispatcher requestDispatcher = request.getRequestDispatcher("jsp/signup.jsp");

            //requestDispatcher.forward(request, response);
            response.sendRedirect("jsp/signup.jsp?error=1");
        }

    }
}
