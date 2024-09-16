module Mutations
  class UpdateCommentMutation < Mutations::BaseMutation
    argument :id, GraphQL::Types::ID, required: true
    argument :content, String, required: true

    field :comment, Types::CommentType, null: true
    field :errors, [String], null: false
    def resolve(id:, content:)
      comment = Comment.find(id)
      return { comment: nil, errors: ["Comment not found"] } if comment.nil
      user = context[:current_user]
      return { comment: nil, errors: ["You don't have permission to edit this comment"] } if user.nil? || user.id != comment.user_id
      { comment: comment, errors: [] } if comment.update(content: content)
    rescue StandardError => e
      {
        comment: nil,
        errors: [ "An error occurred while updating the post: dwad#{e.message}" ]
      }
    end
  end
end