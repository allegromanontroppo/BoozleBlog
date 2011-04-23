class Tag < ActiveRecord::Base
	belongs_to :post 

  	validates_presence_of :tag 
  	validates_presence_of :post_id

	def to_param
		"#{tag}".parameterize 
  	end

end
