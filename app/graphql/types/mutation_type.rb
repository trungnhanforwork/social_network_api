# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::SignUpMutation
    field :log_in, mutation: Mutations::LoginMutation

    field :update_profile_image, mutation: Mutations::UpdateProfileImage

    field :create_post, mutation: Mutations::CreatePostMutation
    field :update_post, mutation: Mutations::UpdatePostMutation
    field :delete_post, mutation: Mutations::DeletePostMutation

    field :update_comment, mutation: Mutations::UpdateCommentMutation
    field :create_comment, mutation: Mutations::CreateCommentMutation
    field :delete_comment, mutation: Mutations::DeleteCommentMutation

    field :follow_user, mutation: Mutations::FollowUserMutation
    field :unfollow_user, mutation: Mutations::UnfollowUserMutation
  end
end
