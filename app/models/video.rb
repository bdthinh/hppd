class Video < ActiveRecord::Base
  # include ElasticSearch::Model
  # include ElasticSearch::Model::Callbacks
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :video_votes_of_users
  has_many :user_votes, through: :video_votes_of_users, source: :user
  mount_uploader :video, VideoUploader
  validates :title, presence: true, uniqueness: true
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
  def to_jq_upload
    {
      "name" => title,
      "size" => video.size,
      "url" => video.url,
      "delete_url" => video_path(video),
      "delete_type" => "DELETE"
    }
  end
end
