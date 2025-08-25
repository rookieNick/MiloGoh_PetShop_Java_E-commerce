package control;

import da.ReviewDA;
import domain.Review;
import java.util.ArrayList;
import java.util.List;

public class MaintainReviewControl {

    private ReviewDA reviewDA;

    public MaintainReviewControl() {
        reviewDA = new ReviewDA();
    }

    public Review selectReviewById(int reviewId) {
        return reviewDA.getReviewById(reviewId);
    }

    public void addReview(Review review) {
        reviewDA.addReview(review);
    }

    public void editReview(Review review) {
        reviewDA.updateReview(review);
    }

    public void deleteReview(int reviewId) {
        reviewDA.deleteReview(reviewId);
    }

    public ArrayList<Review> getAllReviews(int productId) {
        return reviewDA.getAllReviews(productId);
    }

    public int getNewReviewId() {
        List<Review> reviews = getAllReviews(0);
        int latestId = 0;
        int newId = 0;

        for (Review review : reviews) {
            if (review.getReviewid() > latestId) {
                latestId = review.getReviewid();
            }
        }

        if (!reviews.isEmpty()) {
            newId = latestId + 1;
        } else {
            newId = 1;
        }

        return newId;
    }
}
