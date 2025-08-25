/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import domain.Account;
import control.MaintainAccountControl;
import Exception.Password;
import Exception.InvalidPasswordException;

import java.io.IOException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/ForgotPasswordServlet"})
public class ForgotPasswordServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("gmail");
        String newPassword = request.getParameter("newPassword");

        //find if gmail exist
        MaintainAccountControl accountControl = new MaintainAccountControl();
        Account account = accountControl.selectAccuntFromGmail(email);

        
        
        String errorMsg = "";
        
        //if exist
        if (account != null) {

            //check password validation
            Boolean isInvalid = false;

            //password
            try {
                Password pw = new Password(newPassword);
            } catch (InvalidPasswordException ex) {
                isInvalid = true;
                errorMsg += "Invalid password format\n";
            }

            //password validation correct
            if (isInvalid == false) {

                account.setPassword(newPassword);
                accountControl.editRecord(account);
                response.sendRedirect("jsp/forgotPassword.jsp?success=1");
            } else {
                request.getSession().setAttribute("account", account);
                request.getSession().setAttribute("errorMsg", errorMsg);
                response.sendRedirect("jsp/forgotPassword.jsp?error=1");
            }
            //no matched gmail in database
        } else {
                errorMsg += "No such gmail exists\n";
                request.getSession().setAttribute("errorMsg", errorMsg);
                response.sendRedirect("jsp/forgotPassword.jsp?error=1");
        }

    }

}
