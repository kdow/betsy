class Review < ApplicationRecord
  validates :rating, presence: true
  validates_numericality_of :rating,
                            only_integer: true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 5

  def self.avg_rating(product)
    product.reviews.collect { |review| review.rating }.sum.to_f / product.reviews.length if product.reviews.length > 0
  end
end
