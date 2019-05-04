class HomepagesController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller

  def index
    @products = Product.all
  end
end
