
class SellersController < ApplicationController
  before_action :require_login, only: [:show, :product_index, :order_product_index, :order_show, :product_categories_edit]
  before_action :auth_seller_by_id, only: [:show]
  before_action :auth_seller, only: []
  before_action :find_seller, only: [:product_index, :order_product_index, :order_show, :product_categories_edit]

  def show
    @seller = Seller.find_by(id: params[:id])

    unless @seller
      head :not_found
    end
  end

  def product_index
  end

  def order_product_index
    @orders = @seller.get_unique_orders
  end

  def order_show
    @order = Order.find_by(id: params[:order_id])
    unless @order
      head :not_found
      return
    end
    unless @seller.has_order?(@order)
      redirect_to seller_path(@seller)
    end
  end

  def product_categories_edit
    @product = Product.find_by(id: params[:id])
    unless @product
      head :not_found
      return
    end
    unless @seller.has_product?(@product)
      redirect_to seller_path(@seller)
    end
  end

  def create
    auth_hash = request.env["omniauth.auth"]

    seller = Seller.find_by(uid: auth_hash[:uid], provider: "github")
    if seller
      flash[:success] = "Logged in as returning seller #{seller.username}"
    else
      seller = Seller.build_from_github(auth_hash)

      if seller.save
        flash[:success] = "Logged in as new seller #{seller.username}"
      else
        flash[:error] = "Could not create new seller account: #{seller.errors.messages}"
        return redirect_to root_path
      end
    end

    session[:seller_id] = seller.id
    return redirect_to root_path
  end

  def destroy
    session[:seller_id] = nil
    flash[:success] = "Successfully logged out!"

    redirect_to root_path
  end

  private

  def find_seller
    @seller = Seller.find_by(id: params[:seller_id])
    unless @seller
      head :not_found
      return
    end
  end

  def auth_seller_by_id
    unless current_seller.id == params[:id].to_i
      flash[:error] = "You dont have permission to view this page"

      redirect_to seller_path(current_seller)
    end
  end
end
