class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # include RequiresOrganization

  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  # def set_current_user
  #   @current_user = current_user
  # end
end
