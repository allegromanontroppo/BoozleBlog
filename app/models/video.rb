class Video < ActiveRecord::Base
	belongs_to :post
	attr_accessible :embed
	
	validates :embed, :presence => true
end

# == Schema Information
#
# Table name: videos
#
#  id         :integer         not null, primary key
#  post_id    :integer
#  embed      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

