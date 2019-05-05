class OrderController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller
  before_action :find_order, only: [:edit, :update]

  def new
    @order = current_order
  end

  def show
    id = params[:id]
    if session[:order_id] == id.to_i
      @order = Order.find_by(id: session[:order_id])
      if @order
        @order_products = @order.order_products.order(created_at: :desc)
      else
        head :not_found
      end
    end
  end

  # def create
  #   @order = Order.new(order_params)

  #   successful = @order.save
  #   if successful
  #     flash[:status] = :success
  #     flash[:message] = "successfully create the order"
  #     redirect_to orders_path
  #   else
  #     flash.now[:status] = :error
  #     flash.now[:message] = "Could not save the order"
  #     render :new, status: :bad_request
  #   end
  # end

  def edit
    @order.save
  end

  def update
    @order = current_order
    @order_products = current_order.order_products
    Product.adjust_quantity(@order_products)
    @order.status = "completed"
    if @order.update(order_params)
      flash[:status] = :success
      # flash[:message] = "Successfully placed the order"
      #redirect_to order_path(@order)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not complete the order"
      render :new, status: :bad_request
    end
    session[:order_id] = nil
  end

  private

  def find_order
    @order = Order.find_by(id: session[:order_id])
    if @order.nil?
      head :not_found
    end
  end

  def order_params
    params.require(:order).permit(:name, :email, :last_four, :cc_exp, :address, :city, :state, :zip)
  end
end
