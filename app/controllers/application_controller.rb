class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location
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
      u.permit(:email, :password, :name, :birthdate, :phone_number, :address, :city, :avatar)
    end
  end
  def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  return unless request.get?
  if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
    session[:previous_url] = request.fullpath
  end
end

def after_sign_in_path_for(resource)
  session[:previous_url] || root_path
end

end
