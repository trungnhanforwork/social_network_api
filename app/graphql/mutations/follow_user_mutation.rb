module Mutations
  class FollowUserMutation < Mutations::BaseMutation
    argument :followed_user_id, GraphQL::Types::ID , required: true

    type Types::FollowType
    field :errors, [String], null: false

    def resolve(followed_user_id:)
      current_user = context[:current_user]
      followed_user = User.find_by(id: followed_user_id)

      if current_user.nil?
        raise GraphQL::ExecutionError, "You need to be logged in to follow someone"
      end

      if followed_user.nil?
        raise GraphQL::ExecutionError, "User to follow not found"
      end

      if current_user.id == followed_user.id
        raise GraphQL::ExecutionError, "You can't follow yourself"
      end

      follow = Follow.new(follower: current_user, followed: followed_user)

      if follow.save
        {  errors: [] }
      else
        {  errors: follow.errors.full_messages }
      end
    end
  end
end