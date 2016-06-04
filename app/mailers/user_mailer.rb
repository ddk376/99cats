class UserMailer < ApplicationMailer
  default from: 'no-reply@aa.io'

  def welcome_email(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: user.email, subject: 'Welcome to 99cats')
  end
end
