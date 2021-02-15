class SubsController < ApplicationController

    def new
        render :new
    end

    def create
        @sub = Sub.create(sub_params)
        @sub.moderator_id = params[:user_id]

        if @sub.save
        else
            flash[:errors] = @sub.errors.full_messages
        end

        redirect_to user_url(@sub.moderator)  #check this route!
    end

    def edit 
        @sub = Sub.find(params[:id])
        render :edit
    end

    def update 
        @sub = Sub.find(params[:id])
        
        if @sub.update_attributes(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end 

    def destroy 
        @sub = current_user.subs.find_by(id: params[:id])

        if @sub && @sub.delete
            redirect_to users_url
        end
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    def index
        @subs = Sub.all 
        render :index
    end
end
