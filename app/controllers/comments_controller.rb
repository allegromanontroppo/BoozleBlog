class CommentsController < LoggedInController

	def create

		@comment = Comment.new(params[:comment])
    	@comment.user_id = current_user.id
		if @comment.save
			redirect_to post_path(@comment.post_id)
		end 

	end

end

