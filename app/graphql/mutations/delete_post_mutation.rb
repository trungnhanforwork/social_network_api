module Mutations
  class DeletePostMutation < Mutations::BaseMutation
    argument :id, GraphQL::Types::ID, required: true

    field :errors, [String], null: false
    def resolve(id:)
      user = context[:current_user]
      return {post: nil, errors:["Unauthorized"]} if user.nil? || user.id != context[:current_user].id
      post = Post.find(id: id)
      if post.nil?
        raise GraphQL::ExecutionError, "Post with id = #{id} could not be found"
      end
      if post.destroy()
        return  {
          errors: [],
        }
      else
        return GraphQL::ExecutionError, post.errors.full_messages
      end
    rescue StandardError => e
      return {
        post: nil,
        errors: ["An error occured while deleting the post: #{e.message}"]
      }
    end
  end
end