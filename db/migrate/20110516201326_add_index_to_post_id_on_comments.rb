class AddIndexToPostIdOnComments < ActiveRecord::Migration
  
  def self.up
    add_index :comments, :post_id, :name => :index_comments_on_post_id
    add_index :comments, :user_id, :name => :index_comments_on_user_id
    end

  def self.down    
    remove_index :comments, :index_comments_on_post_id
    remove_index :comments, :index_comments_on_user_id    
  end
  
end
