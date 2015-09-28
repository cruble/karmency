class UserMailer < ApplicationMailer

  def moment_mail(user, coin)
    @user = user
    @coin = coin
    @url  = 'http://www.karmency.com/login'
    mail(to: @user.email, subject: "Karmency update on coin #{@coin.code}")
  end
  

end
