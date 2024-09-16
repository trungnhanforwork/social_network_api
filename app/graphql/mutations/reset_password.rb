module Mutations
  class ResetPassword < Mutations::BaseMutation
    argument :token, String, required: true
    argument :new_password, String, required: true

    field :message, String, null: false

    def resolve(token:, new_password:)
      user = User.find_by(reset_password_token: token)

      if user && user.password_token_valid
        user.reset_password!(new_password)
        { message: "Password successfully updated" }
      else
        raise GraphQL::ExecutionError, "Invalid or expired token"
      end
    end
  end
end