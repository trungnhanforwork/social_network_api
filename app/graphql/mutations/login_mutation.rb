module Mutations
  class LoginMutation < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false
    field :token, String, null: true

    def resolve(email:, password:)
      user = User.find_by(email: email)
      if user&.authenticate(password)
        token = JsonWebToken.encode(user_id: user.id)
        { token: token, user: user, errors: [] }
      else
        { token: nil, user: nil, errors: ['Invalid credentials'] }
      end
    end
  end
end