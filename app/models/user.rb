class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :async,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :posts
  has_many :videos
  has_many :video_votes_of_users
  has_many :video_votes, through: :video_votes_of_users, source: :video
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.avatar_url = auth.info.image
      user.birthdate = auth.info.birthdate || nil
    end
  end
  def from_omniauth?
    uid.present? ? true : false
  end
  def is_admin?
    is_admin
  end
  def voted?(video)
    return video_votes.pluck(:id).include?(video.id) ? true : false
  end
  def is_owner?(video)
    return id == video.user_id
  end
end
