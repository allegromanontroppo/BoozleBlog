class AddFlagsAndAvatarToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_super_user, :boolean
    add_column :users, :canpost, :boolean
    add_column :users, :avatar, :string
  end

  def self.down
    remove_column :users, :avatar
    remove_column :users, :can_post
    remove_column :users, :is_super_user
  end
end
