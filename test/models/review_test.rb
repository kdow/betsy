require "test_helper"

describe Review do
  # let(:review) { Review.new }

  # it "must be valid" do
  #   value(review).must_be :valid?
  # end
  describe "validations" do
    let(:review) {reviews(:one)}
    it "must have a rating" do
      review.rating = nil
      result = review.valid?
      expect(result).must_equal false
    end
    it "must have an integer rating" do
      review.rating = "string"
      result = review.valid?
      expect(result).must_equal false
    end
    it "cant have a rating less than 1" do
      review.rating = 0
      result = review.valid?
      expect(result).must_equal false
    end
    it "cant have a rating more than 5" do
      review.rating = 6
      result = review.valid?
      expect(result).must_equal false
    end

  end

  describe "avg_rating" do
    let(:product) { products(:crown) }

    it "calculates the average of available ratings" do
      Review.create!(rating: 5, product_id: product.id)
      Review.create!(rating: 3, product_id: product.id)
      Review.create!(rating: 4, product_id: product.id)

      expect(Review.avg_rating(product)).must_equal 4
    end

    it "returns nil if no ratings" do
      expect(Review.avg_rating(product)).must_be_nil
    end
  end
end
