class CreateCategoriesOfPosts < ActiveRecord::Migration
  def change
    create_table :categories_of_posts do |t|
      t.integer :post_id
      t.integer :category_id
      t.timestamps null: false
    end
    add_index :categories_of_posts, [:post_id, :category_id], unique: true
  end
end
