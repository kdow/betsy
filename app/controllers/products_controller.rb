

class ProductsController < ApplicationController
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

  private

  def product_params
    return params.require(:product).permit(:name, :price, :quantity, :seller_id, :description)
  end
end
