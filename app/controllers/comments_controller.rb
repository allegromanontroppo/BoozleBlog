class CommentsController < ApplicationController
  
  def new
    
    @comment = Comment.new params[:comment]
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_path(@comment.post_id) }
        format.js
      end     
    end 
    
  end

end
