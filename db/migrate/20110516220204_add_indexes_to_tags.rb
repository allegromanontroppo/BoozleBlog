class AddIndexesToTags < ActiveRecord::Migration
  def self.up
    add_index :tags, :post_id, :name => :index_tags_on_post_id
      add_index :tags, :tag, :name => :index_tags_on_tag
  end

  def self.down
    remove_index :tags, :index_tags_on_post_id
    remove_index :tags, :index_tags_on_tag
  end
end
