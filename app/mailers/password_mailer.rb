class PasswordMailer < ApplicationMailer
  def reset_password_email
    @user = params[:user]
    # @reset_url
    mail(to: @user.email, subject: "Password Reset")
  end
end
