class Video < ActiveRecord::Base
  # include ElasticSearch::Model
  # include ElasticSearch::Model::Callbacks
  belongs_to :user
  has_many :video_votes_of_users
  has_many :user_votes, through: :video_votes_of_users, source: :user
  def is_published?
    is_published
  end
  def is_showed_on_tv?
    is_showed_on_tv
  end
  def is_published_in_week(week)
  end
  def is_showed_on_tv_in_week(week)
  end
  def self.search(keyword)
    Video.where("title ~* ?", ".*#{keyword}.*")
  end
end
