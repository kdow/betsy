class OrderController < ApplicationController
  skip_before_action :require_login

  def new
    @order = current_order
  end

  def update
    @order = current_order
    if @order.update(order_params)
      flash[:status] = :success
      flash[:message] = "Successfully placed the order"
      redirect_to order_path(@order)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not place the order"
      render :new, status: :bad_request
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :last_four, :cc_exp, :address, :city, :state, :zip)
  end
end
