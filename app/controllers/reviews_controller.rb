class ReviewsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller

  def index
    @reviews = Review.where(product_id: params[:product_id])
    @product = Product.find_by(id: params[:product_id])
  end

  def new
    @product = Product.find_by(id: params[:product_id])
    @review = @product.reviews.new
  end

  def create
    @product = Product.find_by(id: params[:product_id])

    @review = @product.reviews.new(review_params)

    successful = @review.save
    if successful
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  private

  def review_params
    return params.require(:review).permit(:rating, :description, :product_id)
  end
end
