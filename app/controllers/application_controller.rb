class ApplicationController < ActionController::Base
  # the methods inside here available to the entire controller
  # t available that method in a view define method as helper method
  helper_method :is_login?,:current_user,:redirect_to

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_login?
    !!current_user # return true if logged in otherwise false
  end

  def require_user
    if !is_login?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
