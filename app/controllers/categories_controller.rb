class CategoriesController < ApplicationController
  skip_before_action :require_login, except: [:new, :create]
  skip_before_action :auth_seller

  def index
    @categories = Category.all
  end

  def browse_category
    @categories = Category.all
    @category = Category.find_by(id: params[:category_id])

    unless @category
      head :not_found
    end
  end

  def show
    @category = Category.find_by(id: params[:id])

    unless @category
      head :not_found
    end
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)

    successful = category.save

    if successful
      flash[:success] = "Category added successfully"
      redirect_to category_path(category.id)
    else
      category.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new, status: :bad_request
    end
  end

  private

  def category_params
    return params.require(:category).permit(:name)
  end
end
