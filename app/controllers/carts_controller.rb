class CartsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller

  def show
    @order = current_order
    @order_products = @order.order_products
  end
end
