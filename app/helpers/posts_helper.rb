module PostsHelper
  
	def tags_list(tags_list)

		tags_list.map{|t| link_to t.tag, tag_path(t) }.join(', ').html_safe

	end

end
