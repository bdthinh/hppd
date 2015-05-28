class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :vote_video, :unvote_video]
  skip_before_action :authenticate_user!, only: [:show]
  before_action :authorize_user_videos!, only: [:edit, :update, :destroy]
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.where(user_id: current_user.id)
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    @video.update(user_id: current_user.id)
    respond_to do |format|
      if @video.save
        # format.html { redirect_to @video, notice: 'Video was successfully uploaded.' }
        format.html {
          render json: { url: video_path(@video), message: "Uploaded successfully." }, status: :created, location: @video
        }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html {
          render json: { url: video_path(@video), message: "Updated successfully." }, status: :updated, location: @video
        }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def vote_video
    @video_vote = VideoVotesOfUser.new(video_id: params[:id], user_id: current_user.id)
    @video_vote.save
  end
  def unvote_video
    @video_vote = VideoVotesOfUser.where({video_id: params[:id], user_id: current_user.id})
    @video_vote.destroy_all
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:video, :title, :subtitle, :description, :is_published, :is_showed_on_tv, :showed_date)
    end
end
