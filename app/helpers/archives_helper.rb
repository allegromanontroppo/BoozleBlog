module ArchivesHelper

	def month_name(m = @current_month)
		m.strftime("%B %Y")
	end

end