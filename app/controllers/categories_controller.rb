class CategoriesController < ApplicationController
  skip_before_action :require_login
  skip_before_action :auth_seller

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])

    unless @category
      head :not_found
    end
  end
end
