class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, :dependent => :delete_all
	has_many :tags, :dependent => :delete_all 
	has_many :images, :dependent => :delete_all 
	has_many :videos, :dependent => :delete_all 

  	validates_presence_of :title
  	validates_presence_of :body
  	validates_associated :comments
  	validates_associated :tags
  	validates_associated :images
  	validates_associated :videos

	def to_param
		"#{id} #{title}".parameterize 
	end

	def date_pretty
		self[:created_at].strftime("%A #{self[:created_at].day.ordinalize} %B %Y")
	end
	
end
