package servlet;

import domain.Promotion;
import domain.PromotionService;
import java.io.IOException;
import java.io.PrintWriter;
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
public class viewPromotionDetail extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    @Override
    public void init() throws ServletException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            int promotionId = Integer.parseInt(request.getParameter("id"));
            PromotionService promoService = new PromotionService(em);
            Promotion promotion = promoService.findPromoById(promotionId);
            session.setAttribute("promotionDetails", promotion);
            response.sendRedirect("jsp/Manager/promoProfile.jsp");
        } catch (Exception ex) {

        }
    }
}
