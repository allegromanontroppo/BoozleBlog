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

	def to_param
		"#{id} #{title}".parameterize 
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
