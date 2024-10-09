class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!

  def authorize_admin!
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end
end
