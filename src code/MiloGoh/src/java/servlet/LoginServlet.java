
package servlet;

import control.MaintainAccountControl;
import domain.Account;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve username and password from the request
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate the username and password (You can use MaintainAccountControl for validation)
        MaintainAccountControl accountControl = new MaintainAccountControl();
        Account account = accountControl.getLogin(username,password);

        // Check if the account exists and the password matches
        if (account != null) {
            if (account.getPosition().equals("Customer"))
            {
                request.getSession().setAttribute("account", account);
                request.getSession().setAttribute("staffAccount", account); //betul?
                response.sendRedirect("jsp/home.jsp");
            }
            else if (account.getPosition().equals("Staff") || account.getPosition().equals("Manager"))
            {
                //account for view customer profile use, staffAccount for view own profile use (to prevent staffAccount overwritten by customer account when validating in ProfileServlet)
                request.getSession().setAttribute("account", account);
                request.getSession().setAttribute("staffAccount", account);
                response.sendRedirect("jsp/Manager/staffHome.jsp");
            }
            
            //ADD IF ELSE FOR STAFF, AND FOR STAFF ADD SESSION FOR staffAcount and account
        }
        else {
            //check is it the new staff using id to login
            Account newStaffaccount = accountControl.newStaffGetLogin(username,password);
            if(newStaffaccount != null){
                request.getSession().setAttribute("account", newStaffaccount);
                request.getSession().setAttribute("staffAccount", newStaffaccount);
                response.sendRedirect("jsp/Manager/staffEditProfile.jsp");
            }
            else{
                // Authentication failed, redirect back to the login page with an error message
                response.sendRedirect("jsp/login.jsp?error=1");
            }
        }
    }
}
