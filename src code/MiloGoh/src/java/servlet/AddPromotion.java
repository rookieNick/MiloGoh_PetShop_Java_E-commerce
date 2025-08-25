package servlet;

import domain.Promotion;
import domain.PromotionService;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Date;
import javax.annotation.Resource;
import javax.persistence.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.UserTransaction;

public class AddPromotion extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String description = request.getParameter("description");
            int discount = Integer.parseInt(request.getParameter("discount"));
            String validDate = request.getParameter("validdate");
            Promotion promo = new Promotion(discount, validDate, description);
            PromotionService promoService = new PromotionService(em);
            utx.begin();
            promoService.addPromo(promo);
            utx.commit();

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/viewPromotion");
            dispatcher.forward(request, response);
        } catch (Exception ex) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/viewPromotion");
            dispatcher.forward(request, response);
        }
    }
}
