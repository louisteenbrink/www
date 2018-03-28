class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def kitt
    oauth = request.env["omniauth.auth"]
    @user = User.find_for_kitt_oauth(oauth)
    if @user
      sign_in @user, :event => :authentication
      redirect_to admin_root_path
    else
      flash[:alert] = "Sorry #{oauth.info.first_name}, you are not a City Manager or Admin in Kitt."
      redirect_to root_path
    end
  end
end
