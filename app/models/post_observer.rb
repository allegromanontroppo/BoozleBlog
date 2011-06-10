class PostObserver < ActiveRecord::Observer
  
  def after_create(post)
    
    User.where(:notify_when_new_post => true).find_each do |user|
  	  NewPostMailer.new_post_notification(user, post).deliver
    end
    
  end
  
end