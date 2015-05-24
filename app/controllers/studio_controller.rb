class StudioController < ApplicationController
  skip_before_action :authenticate_user!
  def index
  end
  def introduction
  end
  def contact_us
  end
end
