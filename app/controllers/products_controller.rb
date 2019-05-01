class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])

    unless @product
      head :not_found
      return
    end
  end
end
