class OrderController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller

  def new
    @order = current_order
  end

  def create
    @order = Order.new(order_params)

    successful = @order.save
    if successful
      flash[:success] = "successfully create the order."
      redirect_to orders_path
    else
      flash.now[:error] = "Could not save the order."
      render :new, status: :bad_request
    end
  end

  def edit
    @order.save
  end

  def update
    @order = current_order
    @order_products = current_order.order_products
    if Product.check_quantity(@order_products)
      Product.adjust_quantity(@order_products)
      @order.status = "completed"
    end

    if @order.update(order_params)
      flash[:success] = "Successfully placed the order."
      # flash[:status] = :success
      # flash[:message] = "Successfully placed the order"
      session[:order_id] = nil
      redirect_to order_path(@order)
    else
      flash.now[:error] = "Could not complete the order."

      render :new, status: :bad_request
    end
  end

  private

  def find_order
    @order = Order.find_by(id: session[:order_id])
    if @order.nil?
      head :not_found
    end
  end

  def order_params
    params.require(:order).permit(:name, :email, :last_four, :cc_exp, :address, :city, :state, :zip, :cvv)
  end
end
