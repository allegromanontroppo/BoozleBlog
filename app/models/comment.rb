class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	
	def date_pretty
		self[:created_at].strftime("%A #{self[:created_at].day.ordinalize} %B %Y")
	end
end
