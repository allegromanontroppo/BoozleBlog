class Image < ActiveRecord::Base
	belongs_to :post
  #	validates_presence_of :tag 
end
