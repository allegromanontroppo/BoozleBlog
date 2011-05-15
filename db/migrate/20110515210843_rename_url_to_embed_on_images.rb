class RenameUrlToEmbedOnImages < ActiveRecord::Migration
  def self.up
    rename_column(:images, :url, :embed)
  end

  def self.down
    rename_column(:images, :emded, :url)
  end
end
