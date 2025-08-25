/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import control.MaintainReviewControl;
import domain.Review;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author terra
 */
public class ModifyReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Save new review
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        String content = request.getParameter("content");
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        String rateParam = request.getParameter("rate");
        double rate = 0;
        // Check if the parameter is not null and not empty
        if (rateParam != null && !rateParam.isEmpty()) {
            // Parse the rating value to double
            rate = Double.parseDouble(rateParam);

        } else {

        }
        // Create a new Review object
        Review review = new Review();
        review.setReviewid(reviewId);
        review.setRate(rate);
        review.setContent(content);
        review.setAccountid(accountId);
        review.setProductID(productId);

        MaintainReviewControl reviewControl = new MaintainReviewControl();
        reviewControl.editReview(review);


        response.sendRedirect("jsp/ProductDetailPage.jsp?id=" + productId);
    }
}
