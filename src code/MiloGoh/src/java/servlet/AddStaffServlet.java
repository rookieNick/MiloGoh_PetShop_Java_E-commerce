
package servlet;

import control.MaintainAccountControl;
import domain.Account;
import Exception.Password;
import Exception.InvalidPasswordException;

import java.io.*;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddStaffServlet")
public class AddStaffServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String gmail = request.getParameter("gmail");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String position = "Staff";
        String createBy = request.getParameter("createBy");
        
        
        Boolean isInvalid = false;
        String errorMsg ="";
        
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

        //CHECK DUPLICATE IN DATABASE (ic,username,email,phone)
        MaintainAccountControl accountControl = new MaintainAccountControl();
        ArrayList<Account> accountList = accountControl.selectAllAccuntFromStatus("Active");
        ArrayList<Account> accountList2 = accountControl.selectAllAccuntFromStatus("Unset");
        accountList.addAll(accountList2);   //combine 2 array, dont check Deleted account
        
        for (Account account: accountList) {

        if (account.getGmail() != null && account.getGmail().equals(gmail)) {
            isInvalid = true;
            errorMsg += "Email already exists\n";
        }
        }
        
        //validation end---------------------------
        
        
        // Create an Account object 
        Account account = new Account();
        account.setGmail(gmail);
        account.setPassword(password);
        account.setPosition(position);
        account.setStatus("Unset");
        account.setCreated_by(createBy);
        account.setUpdated_by(createBy);
        
//        account.setUsername("testUsername");
//        account.setBirthday("test birthday");
        
        if (isInvalid == false)
        {
            // Call the addRecord method in MaintainAccountControl to add the new account
            accountControl = new MaintainAccountControl();
            accountControl.addRecord(account);

            //retrieve new account (updated ver)
            account = accountControl.selectAccuntFromGmail(gmail);
            request.getSession().setAttribute("registerStaffAccount", account);
            // Redirect to a success page
            response.sendRedirect("jsp/Manager/registerStaffSuccessful.jsp");
        }
        else
        {
            // Set account object as request attribute
            request.getSession().setAttribute("account", account);
            request.getSession().setAttribute("errorMsg", errorMsg);
            //request.setAttribute("account", account);
            //RequestDispatcher requestDispatcher = request.getRequestDispatcher("jsp/manager.jsp");

            //requestDispatcher.forward(request, response);
            response.sendRedirect("jsp/Manager/addStaff.jsp?error=1");
        }
        
        
    }

}
