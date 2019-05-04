class ApplicationController < ActionController::Base
  helper_method :current_order
  before_action :require_login
  before_action :auth_seller

  private

  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def current_seller
    @current_seller ||= Seller.find(session[:seller_id]) if session[:seller_id]
  end

  def require_login
    if current_seller.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to products_path
    end
  end

  def auth_seller
    raise NotImplementedError
  end
end
