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
	
	accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => lambda { |v| v[:embed].blank? }
	accepts_nested_attributes_for :videos, :allow_destroy => true, :reject_if => lambda { |v| v[:embed].blank? }
	
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

	  year_count = posts.group_by{|post| post.created_at.beginning_of_year}.map do |year| 
	    
      months = posts.select{|p| p.created_at.beginning_of_year ==  year[0] }.group_by{|post| post.created_at.beginning_of_month}.map do |month| 
        { :month => month[0], :count => month[1].count }
      end

      archive << { :year => year[0], :count => year[1].count, :months => months }      
      
    end
    
    archive
    
	end
	
	def self.find_by_year(year)
	  
	  	  all :conditions => { :created_at => (year)..(year + 1.year) }, :order => "created_at", :include => [:comments, :user, :tags]
	  
	end
	
	def self.find_by_month(month)
	  
	  all :conditions => { :created_at => (month)..(month + 1.month) }, :order => "created_at", :include => [:comments, :user, :tags]
	  
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
		
	def allowed_to_edit_or_delete?(current_user)
	  
	  (current_user.is_super_user || current_user.id == self[:user_id] ) unless current_user.nil?
	  
	end
	
end

# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

