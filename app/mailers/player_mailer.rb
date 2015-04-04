class PlayerMailer < ApplicationMailer
  
  def registration_email(player)
    @player = player
    mail(
      to: @player.email,
      subject: 'You have successfully registered with KPTC'
    )
  end
  
  def registration_admin_email(player)
    @player = player
    mail(
      to: 'rzezbiarz@aggosst.com',
      subject: 'New KPTC Registration Received'
    )
  end
  
end
