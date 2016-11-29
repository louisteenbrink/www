class DemodayController < ApplicationController
  def show
    @selected_product_slug = params[:product_slug]
    @batch = @client.batch(params[:id])
    if @selected_product_slug && !@batch.products.map { |p| p["slug"] }.include?(@selected_product_slug)
      redirect_to demoday_path(params[:id])
    end
  end

  def index
    # récupérer le demoday star dans @demoday
    completed_batches = @client.completed
    redirect_to demoday_path(@demoday)
  end
end