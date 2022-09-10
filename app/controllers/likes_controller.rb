class LikesController < ApplicationController
    before_action :authenticate_user,{only:[:create,:destroy]}
    def create
        @like = Like.new(
            user_id: @current_user.id ,
            post_id: params[:post_id]
        )
        @like.save
        redirect_back(fallback_location: "/")
        
    end

    def destroy
        @like = Like.find_by(
            user_id: @current_user.id ,
            post_id: params[:post_id]
        )
        @like.destroy
        redirect_back(fallback_location: "/")
    end

    def index
    end
end
