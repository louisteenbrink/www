class DemodayController < ApplicationController
  def show
    @selected_product_slug = params[:product_slug]
    @batch = @client.batch(params[:id])
    if @selected_product_slug
      @selected_product = @batch.products.select { |p| p["slug"] == @selected_product_slug }.first
      redirect_to demoday_path(params[:id]) unless @selected_product
    end
  end

  def index
    # récupérer le demoday star dans @demoday
    completed_batches = @client.completed
    redirect_to demoday_path(@demoday)
  end
end
