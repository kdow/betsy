require "test_helper"

describe ReviewsController do
  let (:product) { products(:crown) }
  let (:seller) { sellers(:kelly) }

  describe "index" do
    it "should get index" do
      get product_reviews_path(product)
      must_respond_with :success
    end
  end

  describe "new" do
    it "can get the new review page" do
      get new_product_review_path(product.id)

      must_respond_with :success
    end

    it "disallows sellers reviewing own products" do
      perform_login(seller)
      seller.save

      get new_product_review_path(product.id)

      must_respond_with :redirect
      must_redirect_to product_path(product)
    end
  end

  describe "create" do
    before do
      @review_hash = {
        review: {
          rating: 4,
          description: "It was pretty good",
          product: product,
        },
      }
    end

    it "can create a new review" do
      expect {
        post product_reviews_path(product), params: @review_hash
      }.must_change "Review.count", 1

      must_respond_with :redirect
      must_redirect_to product_path(product)
    end

    it "disallows sellers reviewing own products" do
      perform_login(seller)
      seller.save

      expect {
        post product_reviews_path(product), params: @review_hash
      }.wont_change "Review.count"

      must_respond_with :redirect
      must_redirect_to product_path(product)
    end
  end
end
