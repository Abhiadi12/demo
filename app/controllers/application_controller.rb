class ApplicationController < ActionController::Base
  # the methods inside here available to the entire controller
  # t available that method in a view define method as helper method
  attr_accessor:user_object # for get user id before login
  helper_method :is_login?,:current_user,:redirect_to,:current_user

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

  def is_email_exist?(value)
    @user = User.where(email:value)
    if @user.empty?
      false
    else
      self.user_object = @user.take
      true
    end
  end

  def get_user_for_password_change_before_login
    user_object
  end

end
