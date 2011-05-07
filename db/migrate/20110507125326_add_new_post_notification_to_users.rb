class AddNewPostNotificationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :notify_when_new_post, :boolean, :default => true
  end

  def self.down
    remove_column :users, :notify_when_new_post
  end
end
