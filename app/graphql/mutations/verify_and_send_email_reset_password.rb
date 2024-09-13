module Mutations
  class VerifyAndSendEmailResetPassword < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true

    def resolve(email:, password:)
      user = User.find_by(email: email)
      if user && user.authenticate(password)
        user.generate_password_reset_token!
        PasswordMailer.with(user: user).reset_password_email.deliver_now
        { message: "A password reset link has been sent to your email." }
      else
        raise GraphQL::ExecutionError, "Invalid credentials"
      end
    end
  end
end