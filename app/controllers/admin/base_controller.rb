class Admin::BaseController < ActionController::Base
  before_action :check_github_user!

  def check_github_user!
    redirect_to user_github_omniauth_authorize_path unless user_signed_in?
  end
end
