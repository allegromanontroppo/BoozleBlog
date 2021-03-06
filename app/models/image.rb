class Image < ActiveRecord::Base
	belongs_to :post
	attr_accessible :url, :thumbnail
	
	validates :url, :presence => true
end

# == Schema Information
#
# Table name: images
#
#  id         :integer         not null, primary key
#  post_id    :integer
#  embed      :string(255)
#  thumbnail  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

