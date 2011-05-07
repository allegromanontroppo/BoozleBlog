class NewPostMailer < ActionMailer::Base
  default :from => "notifications@rebeccaholland.org"
  
  def new_post_notification(user, post)
        
     @post = post
     mail(:to => user.email,
          :subject => "New post at the Boozle Blog")
   end
end
