class PostMailer < ActionMailer::Base
  
  default :from => 'Boozle Blog <membership@rebeccaholland.org>',
          :return_path => 'Boozle Blog <membership@rebeccaholland.org>'
            
  default_url_options[:host] = 'www.rebeccaholland.org'
  
  def new_post_notification(user, post)
    
    @user = user
    @post = post
    
    mail(:to => user.email_with_name,
        :subject => "There's a new post at the Boozle Blog")
        
  end

  def new_comment_notification(user, comment)

    @user = user
    @comment = comment
    
    mail(:to => user.email_with_name,
         :subject => "There's a new comment at the Boozle Blog")
 
  end
   
end
