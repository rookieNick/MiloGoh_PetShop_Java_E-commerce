package servlet;

import control.MaintainReviewControl;
import domain.Review;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SubmitReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Save new review
        String comment = request.getParameter("content");
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        String rateParam = request.getParameter("rate");
        double rate =0; 
        // Check if the parameter is not null and not empty
        if (rateParam != null && !rateParam.isEmpty()) {
            // Parse the rating value to double
            rate = Double.parseDouble(rateParam);
           
        } else {

        }


        // Create a new Review object
        Review review = new Review();
        review.setRate(rate);
        review.setContent(comment);
        review.setAccountid(accountId);
        review.setProductID(productId);

        // Assuming you have a method to save the review in MaintainReviewControl
        MaintainReviewControl reviewControl = new MaintainReviewControl();
        reviewControl.addReview(review);

        // Redirect back to the same page
        response.sendRedirect("jsp/ProductDetailPage.jsp?id="+productId);
    }
}
