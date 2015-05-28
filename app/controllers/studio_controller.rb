class StudioController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if params[:search] && params[:search].present?
      @videos = Video.search(params[:search])
    else
      @videos = Video.all
    end
    case params[:option]
      when "published"
        @videos = @videos.where(is_published: true)
      when "showed"
        @videos = @videos.where(is_showed_on_tv: true)
    end
  end
  def introduction
  end
  def contact_us
  end
  def test
    
  end
end
