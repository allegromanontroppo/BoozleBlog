class ArchivesController < SideBarController

	before_filter :extract_current_month_from_url
  	
	def index
		@posts = Post.includes(:comments, :user, :tags).where(:created_at => (@current_month)..(@current_month + 1.month))
		redirect_to(:action => 'index') if @posts.empty?
	end

private

    def extract_current_month_from_url

	    if is_valid_year? params[:year]
	      year = params[:year].to_i
	    else
	      redirect_to archives_path(:year => Time.new.year, :month => Time.new.month) and return
	    end

	    if is_valid_month? params[:month]
	      month = params[:month].to_i
	    else
	      redirect_to archives_path(:year => year, :month => Time.new.month) and return
	    end

	    @current_month = Time.local(year, month, 1)

	end

	def is_valid_year?(year_str, pre=1990, post=Time.new.year)
		/^(\d)+$/.match(year_str) {|m| (pre..post).include?(m[0].to_i) }
	end

	def is_valid_month?(month_str)
		/^(\d)+$/.match(month_str) {|m| (1..12).include?(m[0].to_i) }
	end 

end