module Mutations
  class DeletePostMutation < Mutations::BaseMutation
    argument :id, ID, required: true

    field :post, Types::PostType, null: true
    field :errors, [ String ], null: false

    def resolve(id:)
      user = context[:current_user]

      if user.nil? || user.id != context[:current_user].id
        return { post: nil, errors: ["Unauthorized"] }
      end

      post = Post.find_by(id: id)

      if post.nil?
        raise GraphQL::ExecutionError, "Post with id = #{id} could not be found"
      end

      if post.destroy
        { post: post, errors: [] }
      else
        raise GraphQL::ExecutionError, post.errors.full_messages.join(', ')
      end
    rescue GraphQL::ExecutionError => e
      { post: nil, errors: [ e.message ] }
    rescue StandardError => e
      { post: nil, errors: [ "An error occurred while deleting the post: #{e.message}" ] }
    end
  end
end