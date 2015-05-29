class AdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_video, only: [:publish_video, :unpublish_video, :assign_video_showed_on_tv, :unassign_video_showed_on_tv]
  def show_users
    # @users = User.where(is_admin: false)
    @users = User.all.order(is_admin: :desc)
  end
  def publish_video
    @video.update(is_published: true)
    render "video_status.js"
  end
  def unpublish_video
    @video.update(is_published: false)
    render "video_status.js"
  end
  def assign_video_showed_on_tv
    @video.update(is_showed_on_tv: true)
    render "video_status.js"
  end
  def unassign_video_showed_on_tv
    @video.update(is_showed_on_tv: false)
    render "video_status.js"
  end
  def show_videos
    @videos = Video.all.order(created_at: :desc)
  end

  private
  def set_video
    @video = Video.find_by_id(params[:video_id])
  end
end
