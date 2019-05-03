

class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :auth_seller, only: [:create, :edit]

  def index
    @products = Product.all
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
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    @product.seller_id = session[:seller_id]
    @successful = @product.save
    if @successful
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
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :bad_request
    end
  end

  private

  def auth_seller
    unless current_seller.id == params[:seller_id].to_i
      flash[:error] = "You dont have permission to view this page"
      redirect_to seller_path(current_seller)
    end
  end

  def product_params
    return params.require(:product).permit(:name, :price, :quantity, :seller_id, :description)
  end
end
