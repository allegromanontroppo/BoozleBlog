class CommentsController < ApplicationController
  
  def create
  
    post = Post.find params[:comment][:post_id]
    
    @comment = post.comments.build params[:comment]
    @comment.user = current_user
    if @comment.save
      
      respond_to do |format|
        format.html { redirect_to post_path(@comment.post_id) }
        format.js
      end     
      
    else
      render :nothing => true        
    end 
    
  end
  
  def destroy
    
    @comment = Comment.find params[:id]
    if @comment.delete
      
        respond_to do |format|
          format.html { redirect_to post_path(@comment.post_id) }
          format.js
        end     

      else

        render :nothing => true
        
      end
      
    rescue
    
  end

end