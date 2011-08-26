class Tag < ActiveRecord::Base
  belongs_to :post 

  attr_accessible :tag

  validates_presence_of :tag 

  before_save do
  	tag.capitalize!
  end
  
  def self.list 
    
    all :select => "tag, count(*) as count", :order => "tag", :group => "tag"
  
  end

  def to_param
   "#{self.tag}".parameterize
  end

end
