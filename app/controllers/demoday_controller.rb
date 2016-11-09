class DemodayController < ApplicationController
  def show
    @batch = AlumniClient.new.batch(params[:id])
    @batch = {
      id: 25,
      starts_at: "2016-07-04",
      ends_at: "2016-09-02",
      full: true,
      last_seats: false,
      waiting_list: false,
      price_cents: 490000,
      price_currency: "EUR",
      trello_inbox_list_id: "563b38ab4e6b7cef47d36fa8",
      analytics_slug: "paris-july-2016",
      products: [
        {
          name: "Mon beau projet",
          tagline: "Il fait plaisir à Sebastien ce beau projet",
          url: "http://monbeauprojetquidefonce.com"
        }
      ]
    }
  end

  def index
    # récupérer le demoday star dans @demoday
    completed_batches = AlumniClient.new.completed
    redirect_to demoday_path(@demoday)
  end
end