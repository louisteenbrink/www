class EmployerProspectsController < ApplicationController

  def create
    @employer = EmployerProspect.new(employer_prospect_params)
    respond_to do |format|
      if @employer.save
        notify_slack(@employer)
        flash[:notice] = "Thank you for joining Le Wagon's network."
        format.html { redirect_to employers_path }
        format.js
      else
        @positions = Position.all
        format.html { render "pages/employers" }
        format.js # => render "employer_prospects/create.js.erb"
      end
    end
  end

  private

  def notify_slack(employer)
    NotifySlack.perform_later(
      "channel": Rails.env.development? ? "test" : "hiring",
      "username": "www",
      "icon_url": "https://raw.githubusercontent.com/lewagon/mooc-images/master/slack_bot.png",
      "text": employer.to_slack_message
    )
  end

  def employer_prospect_params
    params.require(:employer_prospect).permit(:first_name, :last_name, :email, :phone_number, :company, :website, :message, :targets => [], :locations => [])
  end
end
