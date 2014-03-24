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
    respond_to do |format|
      format.html
      format.json { render json: [@post.title, @post.id]  }
      format.xml  { render  xml: [@post.title, @post.id] }
      format.js   { render   js: @post.title }
    end
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
    @vote = Vote.create(votable: @post, creator: current_user, vote: params[:vote])
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:success] = 'Vote counted.'
        else
          flash[:error] = "You've already voted on this post."
        end
        redirect_to :back
      end
      format.js   #THIS TRIPS OUR VOTE.JS.ERB FILE IN POSTS
    end
  end

  ###################### POST CONTROLLER METHODS (PRIVATE) #####################
  private
    def require_correct_user
      unless (current_user?(@post.creator) || admin_user?)
        flash[:error] = 'You must be the creator of this post to do that.'
        redirect_to root_path
      end
    end

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

    def set_categories
      @categories = Category.all
    end

    def set_post
      @post = Post.find_by(slug: params[:id])
    end
end
