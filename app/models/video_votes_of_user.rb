class VideoVotesOfUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  before_create :plus_the_vote
  before_destroy :minus_the_vote
  def plus_the_vote
    video = Video.find_by_id(video_id)
    video.update(votes: video.votes + 1)
  end
  def minus_the_vote
    video = Video.find_by_id(video_id)
    video.update(votes: video.votes - 1)
  end
end
