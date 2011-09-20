class CommentObserver < ActiveRecord::Observer

  def after_create(comment)

    User.where(:notify_when_new_comment => true).find_each do |user|
      PostMailer.new_comment_notification(user, comment).deliver
    end

  end

end
