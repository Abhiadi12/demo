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
		
		def password
			@user = User.new
		end

		def updatepassword
			if params[:reset][:password] != params[:reset][:repassword]
				flash[:danger]="Must be same as password"
				redirect_to change_password_path
			else
				@user = current_user
				render plain:@user.password
			end
		end

    private
  	def user_params
    	params.require(:user).permit(:username, :email,:password)
    end
    
    def update_user_params
        params.require(:user).permit(:username, :email)
    end
      
end