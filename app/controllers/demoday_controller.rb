class DemodayController < ApplicationController
  def show
    @batch = @client.batch(params[:id])
  end

  def index
    # récupérer le demoday star dans @demoday
    completed_batches = @client.completed
    redirect_to demoday_path(@demoday)
  end
end