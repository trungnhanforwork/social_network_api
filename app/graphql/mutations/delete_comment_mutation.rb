module Mutations
  class DeleteCommentMutation < Mutations::BaseMutation
    argument :id, GraphQL::Types::ID, required: true
    field :comment_id, GraphQL::Types::ID, null: true
    field :message, String, null: true
    def resolve(id:)
      comment = Comment.find_by(id: id)
      raise GraphQL::ExecutionError, 'Comment not found' if comment.nil?
      user = context[:current_user]
      raise GraphQL::ExecutionError, 'Unauthorized' if user.nil? || user.id != comment.user_id
      comment.destroy
      { comment_id: id, message: "Comment successfully deleted" }
    rescue StandardError => e
      raise GraphQL::ExecutionError, "Failed to delete comment: #{e.message}"
    end
  end
end