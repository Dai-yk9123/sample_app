class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"  # => return mail object
    # =>    app/views/user_mailer/account_activation.text.erb
    # =>    app/views/user_mailer/account_activation.html.erb
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end