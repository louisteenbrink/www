class Prospects::SyllabusController < ApplicationController
  def create
    @prospect = Prospect.find_or_create_by(
      email: params[:prospect][:email],
      from_path: params[:prospect][:from_path],
      city: params[:prospect][:city])
    p params

    if @prospect.valid?
      # SEND LINK TO SYLLABUS BY EMAIL (OR VIA CUSTOMER.IO)
    end
  end

end
