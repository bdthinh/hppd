class CreateVideosOfUsers < ActiveRecord::Migration
  def change
    create_table :videos_of_users, id: false do |t|
      t.integer :video_id
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :videos_of_users, [:video_id, :user_id], unique: true
  end
end
