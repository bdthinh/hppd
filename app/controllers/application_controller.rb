class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  def authenticate_admin!
    unless authenticate_user! && current_user.is_admin?
      redirect_to root_path, alert: "Authenticate Admin - Page not found!"
    end
  end
  def authorize_user_profile!
    unless current_user.id == params[:id].to_i
      redirect_to root_path, alert: "Authorize User - Page not found!"
    end
  end
  def authorize_user_videos!
    unless current_user.videos.pluck(:id).include? params[:id].to_i
      redirect_to root_path, alert: "Authorize User - Page not found!"
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :name, :birthdate, :phone_number, :address, :city, :avatar_url)
    end
    # devise_parameter_sanitizer.for(:account_update) do |u|
    #   u.permit(:email, :password, :first_name, :last_name, :dob, :current_password)
    # end
  end
end
