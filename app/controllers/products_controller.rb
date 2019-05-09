class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :auth_seller, only: [:create, :edit, :update]
  before_action :find_product, only: [:show, :edit, :update, :retire]

  def index
    if params[:category_id]
      category = Category.find_by(id: params[:category_id])
      @products = category.products
    else
      @products = Product.all
    end
    @order_product = current_order.order_products.new
  end

  def show; end

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
      @product.is_active = true
      @successful = @product.save
      flash[:success] = "Successfully created product #{@product.name}"
      redirect_to product_path(@product.id)
    else
      flash.now[:error] = "Unable to create product"
      render :new, status: :bad_request
    end
  end

  def edit; end

  def update
    # if params[:product]
    #   successful = @product.update(product_params)
    # else
    #   successful = @product.update(no_product_params)
    # end
    successful = @product.update(product_params)
    if successful
      flash[:success] = "Successfully updated product #{@product.name}"
      redirect_to product_path(@product)
    else
      flash.now[:error] = "Unable to updated product"
      render :edit, status: :bad_request
    end
  end

  def retire
    @product.is_active = false
    @product.save

    redirect_to seller_products_path(current_seller)
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

  def find_product
    @product = Product.find_by(id: params[:id])

    unless @product
      head :not_found
      return
    end
  end
end
