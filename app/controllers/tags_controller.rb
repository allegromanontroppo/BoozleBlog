class TagsController < SideBarController

	def index
    	@tags = Tag.select("tag, count(*) as count").order("tag").group("tag")
	end
	
	def show

		@tag = params[:id]
		@posts = Post.includes(:comments, :user, :tags).where("posts.id in (select post_id from tags where tag like ?)", @tag)
		redirect_to(:action => 'index') if @posts.empty?
	end

end