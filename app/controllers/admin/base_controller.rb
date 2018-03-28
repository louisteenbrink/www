class Admin::BaseController < ActionController::Base
  before_action :check_kitt_user!
  layout 'admin'

  def check_kitt_user!
    redirect_to user_kitt_omniauth_authorize_path unless user_signed_in?
  end

  def log_out
    sign_out
    flash[:notice] = "You are now signed out."
    redirect_to root_path
  end
end
