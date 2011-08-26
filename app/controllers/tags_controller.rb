class TagsController < SideBarController

	def index
	  
    	@tags_listing = Tag.list
    	
	end
	
	def show

		@tag = params[:id].gsub(/-/, ' ')
		@posts = Post.find_by_tag @tag
		
		redirect_to(:action => 'index') if @posts.empty?
		
	end

end