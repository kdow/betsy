class SellersController < ApplicationController
  def create
    auth_hash = request.env["omniauth.auth"]

    seller = Seller.find_by(uid: auth_hash[:uid], provider: "github")
    if seller
      flash[:success] = "Logged in as returning seller #{seller.name}"
    else
      seller = seller.build_from_github(auth_hash)

      if seller.save
        flash[:success] = "Logged in as new seller #{user.name}"
      else
        flash[:error] = "Could not create new seller account: #{seller.errors.messages}"
        return redirect_to root_path
      end
    end

    session[:seller_id] = seller.id
    return redirect_to root_path
  end
end
