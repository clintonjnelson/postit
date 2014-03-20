class CategoriesController < ApplicationController
  before_action :require_logged_in, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end


  ######################### PRIVATE CATEGORIES METHODS #########################
  private
    def category_params
      params.require(:category).permit(:name)
    end
end
