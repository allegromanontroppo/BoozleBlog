class CommentsController < ApplicationController
  
  
  def new
    
    @comment = Comment.new params[:comment]
    
    @comment.user_id = current_user.id
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
    
    begin
    
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

end
