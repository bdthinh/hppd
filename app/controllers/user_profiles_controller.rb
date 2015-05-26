class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :public_profile]
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:public_profile]
  before_action :authorize_user_profile!
  skip_before_action :authorize_user_profile!, only: [:public_profile]

  def show
  end

  def edit
  end

  def update
    if file_params[:file].present?
      uploader = AvatarUploader.new
      uploader.store!(file_params[:file])
      params[:user][:avatar_url] = uploader.url
    end
    respond_to do |format|
      if @user.update(user_profile_params)
        format.html { redirect_to user_profile_path, notice: 'User profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  def public_profile
    @videos = @user.videos
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile
    @user = User.find_by_id(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def file_params
    params.require(:user).permit(:file)
  end
  def user_profile_params
    params.require(:user).permit(:name, :phone_number, :birthdate, :address, :city, :avatar_url)
  end
end
