class AddThumbnailToVideo < ActiveRecord::Migration
  def up
    add_column :videos, :thumbnail_url, :string
  end
  def down
    remove_column :videos, :thumbnail_url
  end
end
