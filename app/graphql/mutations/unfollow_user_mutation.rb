module Mutations
  class UnfollowUserMutation < Mutations::BaseMutation
    argument :followed_user_id, ID, required: true
    type Types::FollowType
    field :errors, [String], null: false

    def resolve(followed_user_id:)
    current_user = context[:current_user]
    followed_user = User.find_by(id: followed_user_id)

    if current_user.nil?
      raise GraphQL::ExecutionError, "You need to be logged in to unfollow someone"
    end

    if followed_user.nil?
      raise GraphQL::ExecutionError, "User to unfollow not found"
    end

    follow = Follow.find_by(follower: current_user, followed: followed_user)

    if follow&.destroy
      {  errors: [] }
    else
      {  errors: ["Failed to unfollow user"] }
    end
    end
  end
end