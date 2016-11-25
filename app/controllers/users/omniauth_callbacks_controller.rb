class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"])
    if @user
      sign_in @user, :event => :authentication
      redirect_to admin_path
    else
      flash[:alert] = "Sorry, your github user does not have Admin rights. Ask @ssaunier"
      redirect_to root_path
    end
  end
end
