class UserMailer < ActionMailer::Base
  default from: "info@bitsbridge.com"

  def otp_code_notification(user, code)
    @user = user
    @code = code
    mail(:to => [@user.email], :subject => "Confirmation code for two way authentication")
  end
end
