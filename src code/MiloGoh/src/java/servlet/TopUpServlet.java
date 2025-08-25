/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "TopUpServlet", urlPatterns = {"/TopUpServlet"})
public class TopUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        int amount = Integer.parseInt(request.getParameter("amount"));
        
        // Retrieve account object from session
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        double wallet = account.getWallet();
        
        double resultAmount = wallet + amount;
        
        // Update the wallet property of the account
        account.setWallet(resultAmount);
        
        // Call the MaintainAccountControl to process the account data
        MaintainAccountControl accountControl = new MaintainAccountControl();
        accountControl.editRecord(account);
        
        // Redirect or forward to a success page
        response.sendRedirect("jsp/profile.jsp?success=1");
    }
    

}
