package servlet;

import domain.Promotion;
import domain.PromotionService;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.UserTransaction;

/**
 *
 * @author zlsy2
 */
public class managePromotion extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String description = request.getParameter("description");
            String validdate = request.getParameter("validdate");
            int promotionid = Integer.parseInt(request.getParameter("id"));
            int discount = Integer.parseInt(request.getParameter("discount"));

            String updateBtn = request.getParameter("updateBtn");
            String activateBtn = request.getParameter("activateBtn");
            String deactivateBtn = request.getParameter("deactivateBtn");
            String deleteBtn = request.getParameter("deleteBtn");

            PromotionService promoService = new PromotionService(em);
            Promotion promo = promoService.findPromoById(promotionid);
            if ("Delete".equals(deleteBtn)) {
                utx.begin();
                promoService.deletePromo(promotionid);
                utx.commit();
            } else {
                if ("Update".equals(updateBtn)) {
                    promo.setDescription(description);
                    promo.setDiscount(discount);
                    promo.setValiddate(validdate);
                    utx.begin();
                    em.merge(promo);
                    utx.commit();
                } else if ("Activate".equals(activateBtn)) {
                    List<Promotion> promoList = promoService.findAll();
                    for (Promotion p : promoList) {
                        if (p.getStatus()) {
                            p.setStatus(false);
                            utx.begin();
                            em.merge(p);
                            utx.commit();
                        }
                    }
                    promo.setStatus(true);
                    utx.begin();
                    em.merge(promo);
                    utx.commit();
                } else if ("Deactivate".equals(deactivateBtn)) {
                    promo.setStatus(false);
                    utx.begin();
                    em.merge(promo);
                    utx.commit();
                }
            }

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("../viewPromotion");
            dispatcher.forward(request, response);
        } catch (Exception ex) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/viewPromotion");
            dispatcher.forward(request, response);
        }
    }
}
