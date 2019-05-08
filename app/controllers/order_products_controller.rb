class OrderProductsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller

  def create
    @order = current_order
    @order_product = OrderProduct.new(order_product_params)
    @order_product.order_id = @order.id
    if OrderProduct.already_in_cart?(@order_product, @order)
      flash[:status] = :error
      flash[:error] = "This item already exists in your cart."
      redirect_to cart_path(session[:order_id])
    else
      @order_product.order_id = @order.id
      @order_product.save
      @order.order_products << @order_product
      @order.save
      session[:order_id] = @order.id
      redirect_to products_path
    end
  end

  def update
    @order = current_order
    @item = @order.order_products.find(params[:id])
    new_quantity = params[:quantity]

    if @item.update(quantity: new_quantity)
      flash[:success] = "Quantity successfuly updated."
      redirect_to cart_path
    else
      flash[:error] = "Sorry. Not enough available items in stock."
      redirect_to cart_path
    end
  end

  def destroy
    @order = current_order
    @item = @order.order_products.find(params[:id])
    @item.destroy
    @order.save
    redirect_to cart_path
  end

  private

  def order_product_params
    params.require(:order_product).permit(:quantity, :product_id)
  end
end
