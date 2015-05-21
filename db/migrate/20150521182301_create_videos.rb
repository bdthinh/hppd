class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :video_url
      t.string :title
      t.string :subtitle
      t.text  :description
      t.integer :votes
      t.boolean :is_published, default: false
      t.boolean :is_showed_on_tv, default: false
      t.datetime :showed_date
      t.timestamps null: false
    end
    add_index :videos, :title, unique: true
  end
end
