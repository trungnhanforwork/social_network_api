module Mutations
  class CreatePostMutation < Mutations::BaseMutation
    argument :content, String, required: true
    argument :user_id, GraphQL::Types::ID, required: true

    field :post, Types::PostType, null: true
    field :errors, [String], null: false

    def resolve(content:, user_id:)
      # Convert user_id to an integer if it is a string to ensure correct handling
      user = User.find_by(id: user_id)

      if user.nil?
        return {
          post: nil,
          errors: ["User with id #{user_id} not found"]
        }
      end

      # Create a new post associated with the user
      post = Post.new(content: content, user: user)

      if post.save
        { post: post, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    rescue StandardError => e
      # Catch any unexpected errors
      {
        post: nil,
        errors: ["An error occurred: #{e.message}"]
      }
    end
  end
end
