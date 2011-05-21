class AddIndexToPostIdOnVideos < ActiveRecord::Migration
  def self.up
    add_index :videos, :post_id, :name => :index_videos_on_post_id
  end

  def self.down
    remove_index :videos, :index_videos_on_post_id
  end
end
