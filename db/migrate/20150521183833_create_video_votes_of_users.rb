class CreateVideoVotesOfUsers < ActiveRecord::Migration
  def change
    create_table :video_votes_of_users, id: false do |t|
      t.integer :user_id
      t.integer :video_id

      t.timestamps null: false
    end
    add_index :video_votes_of_users, [:user_id, :video_id], unique: true
  end
end
