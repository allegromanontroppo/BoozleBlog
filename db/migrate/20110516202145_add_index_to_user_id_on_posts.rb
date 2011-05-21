class AddIndexToUserIdOnPosts < ActiveRecord::Migration
  def self.up
    add_index :posts, :user_id, :name => :index_posts_on_user_id
  end

  def self.down
    remove_index :posts, :index_posts_on_user_id
  end
end
