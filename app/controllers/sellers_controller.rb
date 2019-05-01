class SellersController < ApplicationController
<<<<<<< HEAD
  def show
    @seller = Seller.find_by(id: params[:id])

    unless @seller
      head :not_found
    end
=======
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
>>>>>>> 04cebd6ce873052b07f554a1e48acc17c8e03440
  end
end
