# app/graphql/mutations/sign_up_mutation.rb
module Mutations
  class SignUpMutation < Mutations::BaseMutation
    argument :email, String, required: true
    argument :username, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false
    field :token, String, null: true

    def resolve(email:, username:, password:, password_confirmation:)
      user = User.new(
        username: username,
        email: email,
        password: password,
        password_confirmation: password_confirmation
      )

      if user.save
        token = JsonWebToken.encode(user_id: user.id)
        { token: token, user: user, errors: [] }
      else
        { token: nil, user: nil, errors: user.errors.full_messages }
      end
    end

  end
end
