require 'rdiscount'

class Comment < ActiveRecord::Base
  
  before_create :convert_from_markdown_to_html

	belongs_to :post
	belongs_to :user
  
	validates :body, :presence => true
  default_scope includes(:user)
  
  def self.recent(limit = 5)    
    order('created_at DESC').limit(limit).includes([:user, :post])
  end
	
	def date_pretty		
		created_at.strftime("%A #{ created_at.day.ordinalize} %B %Y")		
	end  
	
  def allowed_to_delete?(current_user)  
    (current_user.is_super_user || current_user.id == user_id ) unless current_user.nil?  
  end
  
private

  def convert_from_markdown_to_html      
    self.body = RDiscount.new(self.body, :filter_html).to_html
  end
	
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  post_id    :integer
#  user_id    :integer
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

