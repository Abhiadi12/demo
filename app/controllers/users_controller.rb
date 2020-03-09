class UsersController < ApplicationController

    before_action :require_user,only: [:show,:edit,:update,:destroy]
    def new #for signup
        @user  = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = " Please Login With Your Credintals "
            redirect_to login_path
        else
            render 'new'
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def index 
				@user = User.all
				
    end

    def edit
				@user = User.find(params[:id])
				if @user != current_user
					flash[:danger] = "Can't Edit other data"
					redirect_to current_user
				end
    end

    def update
				@user = User.find(params[:id])
        if @user.update(update_user_params)
          flash[:success] = "Successfully Modified Your Details"
          redirect_to edit_user_path(@user)
        else
          render 'edit'
        end
		end

	def destroy
		@user = User.find(params[:id])
		session[:user_id] = nil
		@user.destroy
		redirect_to root_path
	end
		
	def password
		@user = User.new
	end

	def updatepassword # manage both forgot password and change password
		if current_user.nil? # login not happen
				if is_email_exist?(params[:reset][:email])
					match_for_password( params[:reset][:password] , params[:reset][:repassword])
				else
					flash[:danger] = " User not exist "
					redirect_to change_password_path
				end
		else
			match_for_password( params[:reset][:password] , params[:reset][:repassword])
		end
	end
		
    private
  	def user_params
    	params.require(:user).permit(:username, :email,:password)
    end
    
    def update_user_params
        params.require(:user).permit(:username, :email)
		end
		
		def match_for_password(password_value , confirm_value)
			if password_value != confirm_value
				flash[:danger]="Must be same as password"
			else
				@user = current_user
				if password_value.length < 6
					flash[:danger]="Please enter a strong password"
				else
					if @user.nil?
						@user = get_user_for_password_change_before_login
					end
					flash[:success] = "Password Change" if @user.update(password:password_value)
				end
			end
			redirect_to change_password_path
		end
end