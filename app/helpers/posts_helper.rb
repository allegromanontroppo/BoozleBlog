module PostsHelper
  
	def tags_list(tags_list)

		tags_list.map{|t| link_to t.tag, tag_path(t) }.join(', ').html_safe

	end

	def archives_list(month, count)

		link_to "#{month.strftime('%B %Y')} (#{count})", archives_path( :month => month.month, :year => month.year )

	end

end
