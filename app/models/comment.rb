class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user

  validates_presence_of :body 
	
	def date_pretty
		self[:created_at].strftime("%A #{self[:created_at].day.ordinalize} %B %Y")
	end
	
end
