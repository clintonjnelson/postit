class PostsController < ApplicationController
  before_action :set_post,        only: [:show, :edit, :update]
  before_action :set_categories,  only: [:edit, :new]

  ########################## DISPLAYING EXISTING POSTS #########################
  def index
    @posts = Post.all
    @categories = Category.all
  end

  def show
    @comment = Comment.new
  end

  ############################ MAKING NEW POSTS ################################
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    binding.pry
    if @post.save
      flash[:success] = "Your post was created"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  ############################## MODIFYING POSTS ###############################
  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Changes Saved"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  ###################### POST CONTROLLER METHODS (PUBLIC) ######################



  ###################### POST CONTROLLER METHODS (PRIVATE) #####################
  private
    def post_params   # could have a category_params too if needed
      params.require(:post).permit(:title, :url, :description)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def set_categories
      @categories = Category.all
    end
end
