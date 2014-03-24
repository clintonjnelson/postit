class SessionsController < ApplicationController
  before_action :require_logged_out,    only: [:new, :create]
  before_action :require_logged_in,     only: [:destroy]

  ################################ LOGIN #######################################
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      # if user.two_factor_auth?
      #   session[:two_factor] = true #generate session[:two_factor]
      #   user.generate_twofactor_pin!
      #   #contact twilio method & pass pin
      #   redirect_to pin_path
      # else
        login(user)
      # end
    else
      flash[:error] = "Incorrect Username or Password."
      render 'new'
    end
  end

  def pin
    # access_denied("Access denied.") unless session[:two_factor]
    # if request.post? && !!User.find_by(username: params[:username])
    #   user = User.find_by(username: params[:username])
    #   if user.pin == params[:pin]
    #     login(user)
    #     user.remove_twofactor_pin!
    #     session[:two_factor] = nil
    #   else
    #     flash[:error] = "Sorry, some info was wrong. Please try again."
    #     redirect_to pin_path
    #   end
    # end
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
