/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import control.MaintainCartControl;
import domain.Account;
import domain.Cart;
import domain.Promotion;
import domain.PromotionService;
import java.io.IOException;
import java.util.ArrayList;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author zlsy2
 */
public class startupServlet extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    MaintainCartControl cartControl;

    public startupServlet() throws Exception {
        cartControl = new MaintainCartControl();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            PromotionService promoService = new PromotionService(em);
            Promotion promo = promoService.findValidPromo();
            if (promo == null) {
                promo = new Promotion(0);
            }
            HttpSession session = request.getSession(true);
            session.setAttribute("promotion", promo);
            ArrayList<Cart> cartList = cartControl.getCartByAccountId(0);
            session.setAttribute("guestCart", cartList);
            Account account = new Account(0, "Guest");
            session.setAttribute("account", account);
        } catch (Exception ex) {

        }
        response.sendRedirect("jsp/home.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
