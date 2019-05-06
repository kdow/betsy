#require "pry"

class OrderProductsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller

  def create
    @order = current_order
    @order_product = OrderProduct.new(order_product_params)
    @order_product.order_id = @order.id
    @order_product.save
    @order.order_products << @order_product
    @order.save
    session[:order_id] = @order.id
    #binding.pry
    redirect_to products_path
  end

  def update
    @order = current_order
    @item = @order.order_products.find(params[:id])
    if @item.quantity < 1
      flash[:message] = "Sorry, this item is out of stock."
      redirect_to cart_path
    else
      @item.update_attributes(order_product_params)
      @items = @order.order_products
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
