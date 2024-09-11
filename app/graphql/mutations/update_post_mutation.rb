module Mutations
  class UpdatePostMutation < Mutations::BaseMutation
    argument :id, GraphQL::Types::ID, required: true
    argument :content, String, required: true

    field :post, Types::PostType, null: true
    field :errors, [String], null: false

    def resolve(id:, content:)
      user = context[:current_user]
      return {post: nil, errors:["Unauthorized"]} if user.nil? || user.id != context[:current_user].id
      post = Post.find_by(id: id)
      if post.nil?
        raise GraphQL::ExecutionError, "Post with id=#{id} could not be found"
      end

      if post.update(content: content)
        return  {
          post: post,
          errors: [],
        }
      else
          return GraphQL::ExecutionError, post.errors.full_messages
      end
    rescue StandardError => e
      return {
        post: nil,
        errors: ["An error occured while updating the post: #{e.message}"]
      }
    end
  end
end