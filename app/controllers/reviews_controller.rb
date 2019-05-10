class ReviewsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller, except: [:new, :create]

  def index
    @product = Product.find_by(id: params[:product_id])
    @reviews = Review.where(product_id: params[:product_id])
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

  def auth_seller
    @current_seller ||= Seller.find(session[:seller_id]) if session[:seller_id]
    if @current_seller
      @product = Product.find_by(id: params[:product_id])
      if @current_seller.id == @product.seller_id
        flash[:error] = "You dont have permission to review this item"
        redirect_to product_path(@product)
      end
    end
  end
end
