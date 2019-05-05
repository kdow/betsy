class OrderController < ApplicationController
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
      flash.now[:error] = "We could not place your order."
      render :new, status: :bad_request
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :last_four, :cc_exp, :address, :city, :state, :zip)
  end
end
