class Tag < ActiveRecord::Base
	belongs_to :post 

	def to_param
		"#{tag}".parameterize 
  	end

end
