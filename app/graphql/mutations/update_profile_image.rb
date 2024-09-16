module Mutations
  class UpdateProfileImage < Mutations::BaseMutation
    argument :id, GraphQL::Types::ID, required: true
    argument :profile_image, ApolloUploadServer::Upload, required: true

    field :user, Types::UserType, null: true
    field :errors, [ String ], null: false

    def resolve(id:, profile_image:)
      user = context[:current_user]
      return { user: user, errors: [ "You have to login first" ] } if user.nil?

      if profile_image
        user.profile_image&.attach(profile_image) # Attach the file to the profile_image field
      end
      if user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
