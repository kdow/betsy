class HomepagesController < ApplicationController
  def index
    @products = Products.all
  end
end
