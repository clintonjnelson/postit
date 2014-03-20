class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Before Filters
  before_filter :load_categories


  ############################## HELPER METHODS ################################
  helper_method :login, :logged_in?, :logged_out?, :current_user, :current_user?
  helper_method :filter_logged_in?, :filter_logged_out?
  ## CAN'T MAKE A GENERIC FILTER_CORRECT_USER BECAUSE USER CHECK CHANGES WITH
      #THE CASE: @comment.creator vs @post.creator vs @user

  private
    def load_categories
      @categories = Category.all
    end

    # VERIFY THIS METHOD
    def current_user
      # Should we use an @current_user ||= or something here?
      @current_user ||= User.find(session[:user_id]) if logged_in?
    end

    # VERIFY THIS METHOD
    # Test match of db(session[:id]) object to user object. Pass @user to method.
    def current_user?(user_obj)
      (User.find(session[:user_id]) == user_obj) if logged_in?
    end

    def login(user)
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}!"
      redirect_to root_path
    end

    def logged_in?
      # !! turns this into a boolean, so we CAN"T get nil
      !!session[:user_id]
    end

    def logged_out?
      session[:user_id].nil?
    end

    def require_logged_in
      if !logged_in?
        flash[:error] = "You must be logged in to do that."
        redirect_to root_path
      end
    end

    def require_logged_out
      if logged_in?
        flash[:error] = "You can't do that while logged in."
        redirect_to root_path
      end
    end
end
