class FollowsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        follow =  Follow.where(user_id: current_user.id)
        render json: follow
    end

    def create 
        follow = Follow.new(user_id: current_user.id, follow_user_id: params[:follow_user_id])
        if follow.save!
            render json: follow
        else
            render json:  follow.errors, status: :unprocessable_entity
        end 
    end

    def destroy
        follow = Follow.find(params[:id])
        if follow.delete
            render :no_content
        else
            render json: follow.errors, status: :unprocessable_entity
        end


    end

    private 
    def follow_params
        params.require(:follow).permit(:user_id, :follow_user_id)
    end
end
