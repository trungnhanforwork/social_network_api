module Mutations
  class UnlikePostMutation < Mutations::BaseMutation
    argument :post_id, ID, required: true


    field :errors, [String], null: false

    def resolve(post_id:)
      current_user = context[:current_user]
      post = Post.find_by(id: post_id)

      if current_user.nil?
        return { errors: ["You need to be logged in to unlike a post"] }
      end

      if post.nil?
        return { errors: ["Post not found"] }
      end

      like = Like.find_by(user: current_user, post: post)

      if like&.destroy
        { errors: [] }
      else
        { errors: ["Failed to unlike the post"] }
      end
    end
  end
end