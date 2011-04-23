class Image < ActiveRecord::Base
	belongs_to :post
  #	validates_presence_of :tag 
  	validates_presence_of :post_id
end
