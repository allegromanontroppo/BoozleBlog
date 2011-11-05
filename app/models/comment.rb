class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user

  validates_presence_of :body 
  
  def self.find_by_post(post)
  
    all :conditions => ["post_id = ?", post.id], :include => :user
  
  end
  
  def self.recent(limit = 5)
    
    all :order => "created_at DESC", :limit => limit, :include => [:user, :post]
    
  end
	
	def date_pretty
		
		self[:created_at].strftime("%A #{self[:created_at].day.ordinalize} %B %Y")
		
	end  
	
  def allowed_to_delete?(current_user)
  
    (current_user.is_super_user || current_user.id == self[:user_id] ) unless current_user.nil?
  
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

