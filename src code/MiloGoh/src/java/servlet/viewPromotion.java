package servlet;

import domain.Promotion;
import domain.PromotionService;
import java.io.IOException;
import java.util.List;
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
public class viewPromotion extends HttpServlet {
    @PersistenceContext
    EntityManager em;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            HttpSession session = request.getSession();
            PromotionService promoService = new PromotionService(em);
            List<Promotion> promoList = promoService.findAll();
            session.setAttribute("promoList", promoList);
            response.sendRedirect("jsp/Manager/managePromotion.jsp");
        }catch(Exception ex){
            
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            HttpSession session = request.getSession();
            PromotionService promoService = new PromotionService(em);
            List<Promotion> promoList = promoService.findAll();
            session.setAttribute("promoList", promoList);
            response.sendRedirect("jsp/Manager/managePromotion.jsp");
        }catch(Exception ex){
            
        }
    }
}
