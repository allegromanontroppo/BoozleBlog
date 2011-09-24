class Post < ActiveRecord::Base
  
	belongs_to :user
	has_many :comments, :dependent => :delete_all
	has_many :tags, :dependent => :delete_all 
	has_many :images, :dependent => :delete_all 
	has_many :videos, :dependent => :delete_all 

	validates_presence_of :title
	validates_presence_of :body
	validates_associated :comments
#	validates_associated :tag
	validates_associated :images
	validates_associated :videos
	
	def self.latest
	  
	  first :order => "created_at desc", :include => [:comments, :user, :tags, :videos, :images] 
	  
	end
	
	def self.teasers(number_to_return = 6)
	  
	  all :order => "created_at desc", :offset => 1, :limit => number_to_return

	end
	
	def self.find_by_tag(tag)
	  
	  all :conditions => ["id in (select post_id from tags where tag like ?)", tag], :order => "created_at DESC",  :include => [:comments, :user, :tags]
	
	end
	
	def self.archive
	  
	  posts = all :select => "created_at", :order => "created_at DESC"

    archive = []

	  year_count = posts.group_by{|post| post.created_at.beginning_of_year}.map do |years| 
	    
      months = posts.select{|p| p.created_at.beginning_of_year ==  years[0] }.group_by{|post| post.created_at.beginning_of_month}.map do |months| 
        { :month => months[0], :count => months[1].count }
      end

      archive << { :year => years[0], :count => years[1].count, :months => months }      
      
    end
    
    archive
    
	end
	
	def self.find_by_year(year)
	  
	  	  all :conditions => { :created_at => (year)..(year + 1.year) }, :order => "created_at DESC", :include => [:comments, :user, :tags]
	  
	end
	
	def self.find_by_month(month)
	  
	  all :conditions => { :created_at => (month)..(month + 1.month) }, :order => "created_at DESC", :include => [:comments, :user, :tags]
	  
	end

	def to_param
		"#{self.id} #{self.title}".parameterize 
	end

	def date_pretty
		self[:created_at].strftime("%A #{self[:created_at].day.ordinalize} %B %Y")
	end
	
	def previous_post
	  if @previous_post.nil?
  	    @previous_post = self.class.first(:conditions => ["created_at < ?", created_at], :order => "created_at desc")
	  end
	  @previous_post
	end

	def next_post
	  if @next_post.nil?
	    @next_post = self.class.first(:conditions => ["created_at > ?", created_at], :order => "created_at asc")
	  end
	  @next_post
	end
	
end
