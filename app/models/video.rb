class Video < ActiveRecord::Base
	belongs_to :post
	
  	validates_presence_of :embed 
end
