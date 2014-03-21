class SessionsController < ApplicationController
  before_action :require_logged_out,    only: [:new, :create]
  before_action :require_logged_in,     only: [:destroy]

  ################################ LOGIN #######################################
  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      login(user)
    else
      flash[:error] = "Incorrect Username or Password."
      render 'new'
    end
  end

  ################################# LOGOUT #####################################
  def destroy
    session[:user_id] = nil
    flash[:success] = "You're now logged out."
    redirect_to root_path
  end


  ############################## HELPER METHODS ################################
  private
end
