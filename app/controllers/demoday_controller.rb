class DemodayController < ApplicationController
  def show
    if params[:id].to_i == 0
      return redirect_to demoday_index_path
    elsif params[:id].to_i.to_s != params[:id]
      return redirect_to demoday_path(params[:id].to_i)
    end

    @batches = Kitt::Client.query(Batch::CompletedQuery).data.batches # For batch selector
    unless @batches.map(&:slug).include? params[:id]
      flash[:alert] = "The Batch ##{params[:id]}'s demoday did not happen yet!"
      return redirect_to demoday_index_path
    end

    @selected_product_slug = params[:product_slug]
    @batch = Kitt::Client.query(Batch::Query, variables: { slug: params[:id] }).data.batch
    @students = Kitt::Client.query(Student::BatchQuery, variables: { batch_slug: @batch.slug }).data.students
    @products = Kitt::Client.query(Product::BatchQuery, variables: { batch_slug: @batch.slug }).data.products
    if @selected_product_slug
      @selected_product = @products.select { |p| p.slug == @selected_product_slug }.first
      return redirect_to demoday_path(params[:id]) unless @selected_product
    end
  end

  def index
    completed_batches = Kitt::Client.query(Batch::CompletedQuery).data.batches
    latest_batch = (completed_batches.select do |b|
      b.demoday_youtube_id.present? && b.city.locale.to_sym == I18n.locale
    end).first || completed_batches.select { |b| b.slug.to_i == 36 }.first
    redirect_to demoday_path(latest_batch.slug)
  end
end
