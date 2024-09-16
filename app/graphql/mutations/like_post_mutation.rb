module Mutations
  class LikePostMutation < Mutations::BaseMutation
    argument :post_id, GraphQL::Types::ID, required: true

    type Types::LikeType
    field :errors, [String], null: false

    def resolve(post_id:)
      current_user = context[:current_user]
      post = Post.find_by(id: post_id)

      if current_user.nil?
        raise GraphQL::ExecutionError, "You need to be logged in to like a post"
      end

      if post.nil?
        raise GraphQL::ExecutionError, "Post not found"
      end

      like = Like.new(user: current_user, post: post)

      if like.save
        { errors: [] }
      else
        {  errors: like.errors.full_messages }
      end
    end
  end
end