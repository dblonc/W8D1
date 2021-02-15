class SessionsController < ApplicationController
        before_action :ensure_logged_in, only: [:destroy]
    def new
        render :new
    end

    def create
        @user = find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )
        if @user.save
            log_in(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end 
    end

    def destroy
        log_out
        redirect_to new_session_url
    end

end
