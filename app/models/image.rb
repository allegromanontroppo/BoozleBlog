class Image < ActiveRecord::Base
	belongs_to :post
	attr_accessible :embed
	
	# validates_presence_of :embed 
end
