class RenameEmbedToUrlOnImages < ActiveRecord::Migration
  def up
    rename_column :images, :embed, :url
  end

  def down
    rename_column :images, :url, :embed
  end
end
