class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: exception.message }
      format.json { render json: [exception.message], status: 403 }
      format.js   { render json: { error: exception.message }, status: :forbidden }
    end
  end

  check_authorization unless: :devise_controller?
end
