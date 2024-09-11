module Mutations
  class DeleteCommentMutation < Mutations::BaseMutation
    argument :id, GraphQL::Types::ID, required: true

    field :errors, [ String ], null: false
    def resolve(id:)
      comment = Comment.find_by(id: id)
      return { errors: ['Comment not found'] } if comment.nil?
      user = context[:current_user]
      return { errors: ['Unauthorized'] } if user.nil? || user.id != comment.user_id
      comment.destroy
    rescue StandardError => e
      { errors: [ "Fail to delete comment: #{e.message}" ] }
    end
  end
end