class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registration_confirmation.subject
  #
  def registration_confirmation(user)
    @user = user

    mail(to: "#{user} <#{user.email}>", subject: "Please confirm your registration")
  end
  
  def reset_password_email(user)
	  @user = user
	  @password_reset_url = 'http://localhost:3000/password_reset?' + @user.password_reset_token
	  mail(:to => user.email, :subject => 'Password Reset Instructions.')
	end

end
