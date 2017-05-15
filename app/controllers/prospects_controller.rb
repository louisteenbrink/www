class ProspectsController < ApplicationController
  def create
    @prospect = Prospect.find_or_create_by(email: params[:prospect][:email], from_path: params[:prospect][:from_path])
    if @prospect.valid?
      ProspectMailer.invite(@prospect).deliver_later
      SubscribeToNewsletter.new(@prospect.email).run
    end
  end
end
