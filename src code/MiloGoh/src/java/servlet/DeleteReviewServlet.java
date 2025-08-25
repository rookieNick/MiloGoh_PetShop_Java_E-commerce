/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import control.MaintainReviewControl;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author terra
 */
public class DeleteReviewServlet extends HttpServlet {

     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the review ID from the request
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        
        // Delete the review using MaintainReviewControl
        MaintainReviewControl reviewControl = new MaintainReviewControl();
        reviewControl.deleteReview(reviewId);
        
        // Redirect back to the product detail page
        response.sendRedirect("jsp/ProductDetailPage.jsp?id=" + request.getParameter("productId"));
    }
}
