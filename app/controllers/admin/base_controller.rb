class Admin::BaseController < ActionController::Base
  before_action :check_github_user!
  layout 'admin'

  def check_github_user!
    redirect_to user_github_omniauth_authorize_path unless user_signed_in?
  end

  def log_out
    sign_out
    flash[:notice] = "You are now signed out."
    redirect_to root_path
  end
end
