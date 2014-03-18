class CategoriesController < ApplicationController
  binding.pry

  def new
  end

  def create
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end
end
