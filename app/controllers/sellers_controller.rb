class SellersController < ApplicationController
  def show
    @seller = Seller.find_by(id: params[:id])

    unless @seller
      head :not_found
    end
  end
end
