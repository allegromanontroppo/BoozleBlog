class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, :dependent => :delete_all 
	has_many :tags, :dependent => :delete_all 
	has_many :images, :dependent => :delete_all 
	has_many :videos, :dependent => :delete_all 

	def to_param
		"#{id} #{title}".parameterize 
	end

	def date_pretty
		self[:created_at].strftime("%A #{self[:created_at].day.ordinalize} %B %Y")
	end
	
end
