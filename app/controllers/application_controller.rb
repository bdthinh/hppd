class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  def authenticate_admin!
    unless authenticate_user! && current_user.is_admin?
      redirect_to root_path, alert: "Page not found!"
    end
  end
  def authorize_user_profile!
    unless current_user.id == params[:id].to_i
      redirect_to root_path, alert: "Page not found!"
    end
  end
  def authorize_user_videos!
    unless current_user.videos.pluck(:id).include? params[:id].to_i
      redirect_to root_path, alert: "Page not found!"
    end
  end
end
