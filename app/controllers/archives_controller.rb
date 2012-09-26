class ArchivesController < SideBarController

	before_filter :extract_current_month_from_url
  	
	def index
	  
	  if params[:month].nil?	  
  		@posts =Post.find_by_year(@current_month) 
  		@title = @current_month.strftime("%Y")  		
  	else  	  
    	@posts = Post.find_by_month(@current_month)
    	@title = @current_month.strftime("%B %Y")  	  
  	end
  	
	end	

private

  def extract_current_month_from_url

    if is_valid_year? params[:year]
      year = params[:year].to_i
    else
      redirect_to archives_url(:year => Time.new.year, :month => Time.new.month) and return
    end

    if is_valid_month? params[:month]
      month = params[:month].to_i
    end

    @current_month = Time.local(year, month || 1, 1)

	end

	def is_valid_year?(year_str, pre = 1990, post = Time.new.year)
		/^(\d)+$/.match(year_str) { |m| (pre..post).include?(m[0].to_i) }
	end

	def is_valid_month?(month_str)
		/^(\d)+$/.match(month_str) { |m| (1..12).include?(m[0].to_i) }
	end 

end