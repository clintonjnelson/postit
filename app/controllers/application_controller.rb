class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Before Filters
  before_filter :load_categories


  ############################## HELPER METHODS ################################
  helper_method :login, :logged_in?, :logged_out?, :current_user, :current_user?
  helper_method :admin_user?
  helper_method :require_logged_in, :require_logged_out, :require_admin_user

  private
    def load_categories
      # STILL NEED TO GET THE DROPDOWN LIST SORTED ALPHABETICALLY
      @categories = Category.all.sort_by(&:name)
    end

    # Load current_user via sessions, unless already loaded. Must be logged in.
    def current_user
      @current_user ||= User.find(session[:user_id]) if logged_in?
    end

    # Test match of db(session[:id]) object to user object. Pass @user to method.
    def current_user?(user_obj)
      (User.find(session[:user_id]) == user_obj) if logged_in?
    end

    # Verify if current_user's role is admin
    def admin_user?
      (current_user.role == 'admin') if logged_in?
    end

    # Log user in using sessions, flash, redirect.
    def login(user)
      session[:user_id] = user.id
      flash[:success] ||= "Welcome, #{user.username}!"
      redirect_to user_path(user)
    end

    # Verify current user is logged in via sessions.
    def logged_in?
      # !! turns this into a boolean, so we DON'T get nil
      !!session[:user_id]
    end

    # Verify current user is logged out via sessions.
    def logged_out?
      session[:user_id].nil?
    end

    # Shared method for error/redirecting
    def access_denied(msg)
      flash[:error] = msg
      redirect_to root_path
    end

    def require_admin_user
      access_denied("That is for admin only.") unless admin_user?  #props to Chris for the "access denied" gold
    end

    # before_action filter to ensure current user is logged in.
    def require_logged_in
      access_denied("You must be logged in to do that.") unless logged_in?
    end

    # before_action filter to ensure current user is logged out.
    def require_logged_out
      access_denied("You can't do that while logged in.") if logged_in?
    end
end
