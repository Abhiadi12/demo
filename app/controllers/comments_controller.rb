class CommentsController < ApplicationController
 def edit
  @comment = Comment.find(params[:id])
 end

 def update
 end

 def destroy
  @comment = Comment.find(params[:id])
  @comment.destroy
  redirect_to @comment.article
 end

  private
    def comment_params
      params.require(:comment).permit(:description)
    end
end