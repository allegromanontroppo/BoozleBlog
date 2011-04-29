class Tag < ActiveRecord::Base
	belongs_to :post 

    validates_presence_of :tag 

    before_save do
    	tag.capitalize!
  	end

	def to_param
     "#{self.tag}".parameterize
  	end

end
