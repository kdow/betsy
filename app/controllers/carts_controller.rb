class CartsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller

  def show
    @order_products = current_order.order_products
  end
end
