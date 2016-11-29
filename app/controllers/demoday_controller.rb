class DemodayController < ApplicationController
  def show
    @selected_product_slug = params[:product_slug]
    @batch = @client.batch(params[:id])
    if @selected_product_slug
      @selected_product = @batch.products.select { |p| p["slug"] == @selected_product_slug }.first
      redirect_to demoday_path(params[:id]) unless @selected_product
    end
    @batches = @client.completed.reverse
  end

  def index
    completed_batches = @client.completed
    latest_batch = (completed_batches.select do |b|
      b.youtube_id.present? && b.city['course_locale'].to_sym == I18n.locale
    end).last || completed_batches.select { |b| b.slug.to_i == 36 }.first
    redirect_to demoday_path(latest_batch.slug)
  end
end
