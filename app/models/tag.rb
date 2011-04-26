class Tag < ActiveRecord::Base
	belongs_to :post 

    validates_presence_of :tag 

    before_save do
    	tag.capitalize!
  	end

	def to_param
		"#{tag}".parameterize 
  	end

end
