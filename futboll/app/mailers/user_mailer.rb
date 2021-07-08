class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Account Activation"
      ) do |format|
        format.html
      end
  end

  def password_reset
    @greeting = "こんにちは"

    mail to: "to@example.org"
  end
end
