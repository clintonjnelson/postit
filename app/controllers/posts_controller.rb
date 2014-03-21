class PostsController < ApplicationController
  before_action :set_post,            only: [:show, :edit, :update, :vote]
  before_action :set_categories,      only: [:edit, :new]

  before_action :require_logged_in,     only: [:new, :create, :vote]
  before_action :require_correct_user,  only: [:edit, :update]

  ########################## DISPLAYING EXISTING POSTS #########################
  def index
    @posts = Post.all.sort_by(&:net_votes).reverse
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
    post = Post.new(post_params)
    post.creator = current_user
    if post.save
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

  def vote
    @vote = Vote.new(votable: @post, creator: current_user, vote: params[:vote])
    if @vote.save
      flash[:success] = "Vote counted."
    else
      flash[:error] = "You've already voted on this post."
    end
    redirect_to :back
  end

  ###################### POST CONTROLLER METHODS (PRIVATE) #####################
  private
    def require_correct_user
      if !current_user?(@post.creator)
        flash[:error] = 'You must be the creator of this post to do that.'
        redirect_to root_path
      end
    end

    def post_params   # could have a category_params too if needed
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

    def set_categories
      @categories = Category.all
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
