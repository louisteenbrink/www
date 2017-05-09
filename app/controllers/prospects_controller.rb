class ProspectsController < ApplicationController
  def create
    @prospect = Prospect.find_or_create_by(email: params[:prospect][:email])
    ProspectMailer.invite(@prospect).deliver_now
    respond_to do |format|
      format.js
    end
  end
end
