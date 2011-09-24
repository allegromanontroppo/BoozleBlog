module ArchivesHelper

  def archives_month_link(month, count)
  	link_to "#{month.strftime('%B %Y')} (#{count})", month_archives_path( :month => month.month, :year => month.year )
  end

  def archives_year_link(year, count)
  	link_to "#{year.strftime('%Y')} (#{count})", year_archives_path( :year => year.year )
  end

end