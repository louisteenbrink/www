class ProspectsController < ApplicationController
  def create
    @prospect = Prospect.create(prospect_params)
    respond_to do |format|
      format.js
    end
  end

  private
  def prospect_params
    params.require(:prospect).permit(:email)
  end
end
