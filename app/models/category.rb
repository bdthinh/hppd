class Category < ActiveRecord::Base
  has_many :categories_of_posts
  has_many :posts, through: :categories_of_posts
end
