module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :verify_admin
    
    skip_authorization_check

    protected

    def verify_admin
      message = "You are not authorized to access this page."
      redirect_to root_path, alert: message unless current_user.admin?
    end
  end
end
