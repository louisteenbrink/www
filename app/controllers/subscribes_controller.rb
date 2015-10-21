class SubscribesController < ApplicationController
  respond_to :json

  def create
    render json: SubscribeToNewsletter.new(params[:email]).run
  end
end
