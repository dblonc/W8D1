class UsersController < ApplicationController
    #new, create, index, show

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.create(user_params)

        if @user.save
            log_in(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ["Password is too short"]
            render :new
        end
    end

    def index 
        @users = User.all
        render :index
    end

    def show
        @user = User.find(id: params[:id])
        render :show
    end


    private 
    
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
