class Post < ActiveRecord::Base
  has_many :categories_of_posts, dependent: :destroy
  has_many :categories, through: :categories_of_posts
  belongs_to :admin, class_name: "User", foreign_key: "admin_id"
  validates :title, uniqueness: true
end
