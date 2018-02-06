class EmployerProspectsController < ApplicationController
  http_basic_authenticate_with name: ENV['EMPLOYER_PROSPECTS_USERNAME'], password: ENV['EMPLOYER_PROSPECTS_SECRET'], only: :index

  def index
    if params[:city]
      @employers = EmployerProspect.where("? = ANY (locations)", params[:city])
    else
      @employers = EmployerProspect.all
    end
  end

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
      "username": "Employer Prospect",
      "icon_url": "https://raw.githubusercontent.com/lewagon/mooc-images/master/slack_bot.png",
      "attachments": [
        "color": "#2980b9",
        "attachment_type": "default",
        "fallback": "New Employer Prospect (#{employer.company})",
        "fields": [
          {
            "title": "Name",
            "value": employer.full_name,
          },
          {
            "title": "Phone number",
            "value": employer.phone_number,
            "short": true
          },
          {
            "title": "Email",
            "value": employer.email,
            "short": true
          },
          {
            "title": "Company",
            "value": employer.company,
            "short": true
          },
          {
            "title": "Website",
            "value": employer.website,
            "short": true
          },
          {
            "title": "Why",
            "value": employer.message,
          },
          {
            "title": "Which cities",
            "value": employer.locations.join(", ")
          },
          {
            "title": "Looking for",
            "value": employer.targets.join(", ")
          }
        ]
      ]
    )
  end

  def employer_prospect_params
    params.require(:employer_prospect).permit(:first_name, :last_name, :email, :phone_number, :company, :website, :message, :targets => [], :locations => [])
  end
end
