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
      flash[:success] = "Welcome to Postit!"
      login(@user) #log the user in

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
      @user = User.find_by(slug: params[:id])
    end

    def require_correct_user
      access_denied("You are not the appropriate user.") unless current_user == @user
    end

    def user_params
      params.require(:user).permit(:username,
                                   :email,
                                   :timezone,
                                   :phone,
                                   :password,
                                   :password_confirmation)
    end
end
