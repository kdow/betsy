class ProductsController < ApplicationController
  def index
    @products = Product.all
    # @order_item = current_order.order_products.new
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
      # flash[:status] = :success
      # flash[:message] = "successfully saved a product with ID #{@product.id}"
    else
      # flash.now[:status] = :warning
      # flash.now[:message] = "A problem occurred: Could not create #{@product.category}"
      # @errors = @product.errors
      render :new, status: :bad_request
    end
  end

  private

  def product_params
    return params.require(:product).permit(:name, :price, :quantity, :seller_id, :description)
  end
end
