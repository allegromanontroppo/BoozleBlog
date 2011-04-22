class SideBarController < LoggedInController

	before_filter :load_archive_and_tags!, :except => [:create, :upate, :destroy]

 private 

	def load_archive_and_tags!

	    @archives = Post.select("created_at").order("created_at DESC").group_by{|post| post.created_at.beginning_of_month}.map do |grouped_posts| 
	                  { :month => grouped_posts[0], :posts_count => grouped_posts[1].count }
	                end

	    @tags = Tag.select("tag, count(*) as count").order("count desc, tag").group("tag")

  end

end