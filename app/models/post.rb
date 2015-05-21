class Post < ActiveRecord::Base
  has_many :categories_of_posts
  has_many :categories, through: :categories_of_posts
  belongs_to :user
end
