class ReviewsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller

  def new
    @review = Review.new
  end

  def create
    @product = Product.find_by(id: params[:id])

    @review = Review.new(review_params)

    successful = @review.save
    if successful
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  private

  def review_params
    return params.require(:review).permit(:rating, :description)
  end
end
