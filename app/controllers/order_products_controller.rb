class OrderProductsController < ApplicationController
  def create
    @order = current_order
    @order_product = @order.order_products.new(order_product_params)
    @order.save
    session[:order_id] = @order.id
    redirect_to products_path
  end

  def update
    @order = current_order
    @item = @order.order_products.find(params[:id])
    @item.update_attributes(product_params)
    @items = @order.order_products
    redirect_to cart_path
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
