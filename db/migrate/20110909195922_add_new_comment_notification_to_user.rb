class AddNewCommentNotificationToUser < ActiveRecord::Migration
  def change
    add_column :users, :notify_when_new_comment, :boolean, :default => false
  end
end
