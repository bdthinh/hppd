class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :phone_number
      t.string  :name
      t.datetime :birthdate
      t.string  :address
      t.string  :city
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :user_profiles, :user_id
  end
end
