
class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :auth_seller, only: [:create, :edit, :update]

  def index
    if params[:category_id]
      category = Category.find_by(id: params[:category_id])
      @products = category.products
    else
      @products = Product.all
    end
    @order_product = current_order.order_products.new
  end

  def show
    @product = Product.find_by(id: params[:id])

    unless @product
      head :not_found
      return
    end
  end

  def new
    if params[:category_id]
      category = Category.find_by(id: params[:category_id])
      @products = category.products.new
    else
      @products = Product.new
    end
  end

  def create
    @product = Product.new

    if params[:product]
      @successful = @product.update(product_params)
    else
      @successful = @product.update(no_product_params)
      # @successful = @product.update(no_product_params, category_params)
    end

    if @successful
      @product.seller_id = session[:seller_id]
      @successful = @product.save
      redirect_to product_path(@product.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
    unless @product
      head :not_found
      return
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    unless @product
      head :not_found
      return
    end
    # if params[:product]
    #   successful = @product.update(product_params)
    # else
    #   successful = @product.update(no_product_params)
    # end
    successful = @product.update(product_params)
    if successful
      redirect_to product_path(@product)
    else
      render :edit, status: :bad_request
    end
  end

  private

  # def auth_seller
  #   @current_seller ||= Seller.find(session[:seller_id]) if session[:seller_id]
  #   unless current_seller.id == params[:seller_id].to_i
  #     flash[:error] = "You dont have permission to view this page"
  #     redirect_to seller_path(current_seller)
  #   end
  # end

  def product_params
    return params.require(:product).permit(:name, :price, :quantity, :seller_id, :description, :photo_url, category_ids: [])
  end

  def no_product_params
    return params.permit(:name, :price, :quantity, :seller_id, :description, :photo_url)
  end
end
