class ProspectsController < ApplicationController
  def create
    @prospect = Prospect.find_or_create_by(email: params[:prospect][:email], from_path: params[:prospect][:from_path], city: params[:prospect][:city])
    if @prospect.valid?
      ProspectMailer.invite(@prospect).deliver_later
      SubscribeToNewsletter.new(@prospect.email, from_path: @prospect.from_path, free_track: true, city: @prospect.city).run
    end
  end
end
