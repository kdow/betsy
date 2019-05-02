class OrderController < ApplicationController
  def new
    @order = current_order
  end

  # def create

  #   @order = Order.new(order_params)

  #   successful = @order.save
  #   if successful
  #     flash[:status] = :success
  #     flash[:message] = "successfully saved the order"
  #     redirect_to orders_path
  #   else
  #     flash.now[:status] = :error
  #     flash.now[:message] = "Could not save book"
  #     render :new, status: :bad_request
  #   end
  # end

  def update
    @order = current_order
    if @order.update(order_params)
      flash[:status] = :success
      flash[:message] = "Successfully placed the order"
      redirect_to order_path(@book)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not place the order"
      render :edit, status: :bad_request
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :last_four, :cc_exp, :address, :city, :state, :zip)
  end
end
