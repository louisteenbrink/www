class Prospects::SyllabusController < ApplicationController
  def create
    @prospect = Prospect.find_or_create_by(
      email: params[:prospect][:email],
      name: params[:prospect][:name],
      from_path: params[:prospect][:from_path],
      origin: params[:prospect][:origin] || "syllabus",
      city: params[:prospect][:city])
    if @prospect.valid?
      ProspectMailer.send_syllabus(@prospect.id).deliver_later
      # SEND LINK TO SYLLABUS BY EMAIL (OR VIA CUSTOMER.IO)
    end
  end
end
