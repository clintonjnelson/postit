class UsersController < ApplicationController
  before_action :set_user,             only: [:show, :edit, :update, :destroy]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  ################################ MAKE USER ###################################
  def new
    @user = User.new
  end

  def create
    #before_filter to make sure user is not signed_in
    @user = User.new(user_params)
    if @user.save
      login(@user) #log the user in
      flash[:success] = "Welcome to Postit!"
      redirect_to user_path(@user)
      # sign-in user here to cache their remember_token
    else
      render 'new'
    end
  end

  ################################ USER PROFILE ################################
  def show
    #KEEP THIS CODE HER FOR THE SHOW.HTML.ERB in USERS
    #<p> <%= !!@user.timezone                                 %> </p>
    #<p> <%= !!(@user.auth? ? 'ON' : 'OFF')                   %> </p>
    #<p> <%= !!(@user.phone? ? @user.phone : 'Not Available') %> </p>
  end

  def edit
  end

  def update
    # need a before filter method that makes sure user is signed in.
    # need a before filter that makes sure the current user is also the @user.
      #Add in controller: @user[:password_confirmation] = params[:user][:password_confirmation]
      #Also add in controller: @user[:password] = params[:user][:password]
    if @user.update(user_params)
      flash[:success] = "Profile Updated"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  ################################### ADMIN ONLY ###############################
  def index
    #before_action check admin
    @users = User.all
  end

  def destroy
    #before_action check admin
  end


  ################################ HELPER METHODS ##############################
  private
    def set_user
      @user = User.find(params[:id])
    end

    def require_correct_user
      current_user == @user
    end

    def user_params
      params.require(:user).permit(:username, :email, :password )
    end
end
