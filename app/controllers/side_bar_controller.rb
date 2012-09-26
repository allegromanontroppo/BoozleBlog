class SideBarController < LoggedInController
	
 before_filter :load_archive_and_tags!, :except => [:create, :update, :destroy]

 private 

	def load_archive_and_tags!
	  @archives = Post.archive
	  @tags_list = Tag.list
	  @recent_comments = Comment.recent
  end

end