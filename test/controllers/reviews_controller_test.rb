require "test_helper"

describe ReviewsController do
  let (:product) { products.first }

  describe "new" do
    it "can get the new review page" do
      get new_product_review_path(product)

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new review" do
      review_hash = {
        review: {
          rating: 4,
          description: "It was pretty good",
          product: product,
        },
      }

      expect {
        post product_reviews_path(product), params: review_hash
      }.must_change "Review.count", 1

      new_review = Review.find_by(product: review_hash[:review][:product])
      expect(new_review.product).must_equal review_hash[:review][:product]

      must_respond_with :redirect
      must_redirect_to product_path(product)
    end
  end
end
