class CommentsController < ApplicationController
    
    def create
        if !params[:comment] || params[:comment] == "" 
            flash[:alert] = "コメントが入力されていません"
            redirect_to("/posts/#{params[:post_id]}")
        else
            @comment = Comment.new(
                comment: params[:comment] ,
                user_id: @current_user.id ,
                post_id: params[:post_id]
            )
            @comment.save
            redirect_to("/posts/#{params[:post_id]}")
        end
    end

    def edit
        @comment = Comment.find_by(id: params[:id])
    end

    def update
        @comment = Comment.find_by(id: params[:id])
        @comment.comment = params[:comment]
        if @comment.save
            redirect_to("/posts/#{@comment.post_id}")
        else
            render("comments/edit")
        end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id])
        @comment.destroy
        redirect_to("/posts/#{@comment.post_id}")
    end

end
