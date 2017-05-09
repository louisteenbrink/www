class ProspectMailer < ApplicationMailer
  def invite(prospect)
    @prospect = prospect

    mail(to: @prospect.email, subject: 'Join Le Wagon free online track!')
  end
end
