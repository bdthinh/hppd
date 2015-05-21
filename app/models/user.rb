class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :posts
  has_many :video_votes_of_users
  has_many :videos_of_users
  has_many :videos, through: :videos_of_users
  has_many :video_votes, through: :video_votes_of_users
  has_one :user_profile

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name
      # user.avatar_url = auth.info.image
      # user.birthdate = auth.info.birthdate || Date.new(1990,1,1)
    end
  end
end
