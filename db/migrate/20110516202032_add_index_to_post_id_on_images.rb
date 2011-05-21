class AddIndexToPostIdOnImages < ActiveRecord::Migration
  def self.up
    add_index :images, :post_id, :name => :index_images_on_post_id
  end

  def self.down
    remove_index :images, :index_images_on_post_id
  end
end
