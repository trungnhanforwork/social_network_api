module Mutations
  class CreateCommentMutation < Mutations::BaseMutation
    argument :post_id, GraphQL::Types::ID, required: true
    argument :content, String, required: true

    type Types::CommentType
    field :comment, Types::CommentType, null: true
    field :errors, [ String ], null: true

    def resolve(post_id:, content:)
      user = context[:current_user]
      return { errors: [ "Authentication required" ] } unless user

      post = Post.find_by(id: post_id)
      return { errors: [ "Post not found" ] } unless post

      comment = post.comments.build(content: content, user: user)
      if comment.save
        { comment: comment, errors: [] }
      else
        { comment: nil, errors: comment.errors.full_messages }
      end
    end
  end
end