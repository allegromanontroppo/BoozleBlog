class Tag < ActiveRecord::Base
  belongs_to :post 

  attr_accessible :tag
  validates_presence_of :tag 

  before_save do
  	tag.capitalize!
  end
  
  def self.list 
    select('tag, count(*) as count').order('tag').group('tag')
  
  end

  def to_param
   "#{self.tag}".parameterize
  end

end

# == Schema Information
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  post_id    :integer
#  tag        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

