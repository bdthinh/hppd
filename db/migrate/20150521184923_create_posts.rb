class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :subtitle
      t.text :content
      t.integer :admin_id
      t.timestamps null: false
    end
    add_index :posts, :title, unique: true
  end
end
