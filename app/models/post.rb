class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :tags
	has_many :images
	has_many :videos

	def to_param
		"#{id} #{title}".parameterize 
	end

	def date_pretty
		self[:created_at].strftime("%A #{self[:created_at].day.ordinalize} %B %Y")
	end
	
end
