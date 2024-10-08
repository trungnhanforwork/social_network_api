# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [ Types::NodeType, null: true ], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ ID ], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :user, Types::UserType, null: true, description: "Fetches a user object." do
      argument :id, GraphQL::Types::ID, required: true
    end
    def user(id:)
      User.find_by(id: id)
    rescue ActiveRecord::RecordNotFound
      raise GraphQL::ExecutionError, "User not found"
    end


    field :posts, [Types::PostType], null: true, description: "Fetches a list of posts." do
    end
    def posts
      Post.all
    end

    field :post, Types::PostType, null: true, description: "Fetch a post by id."do
      argument :id, GraphQL::Types::ID, required: true
    end
    def post(id:)
      Post.find_by(id: id)
    rescue ActiveRecord::RecordNotFound
      raise GraphQL::ExecutionError, "Post not found"
    end

    field :following_posts, [ Types::PostType ], null: true, description: "Fetch posts of following."
    def following_posts
      current_user = context[:current_user]
      return [] unless current_user.present?
      Post.joins(:user)
          .where(user: context[:current_user].following)
          .order(created_at: :desc)
      if posts.empty?
        { posts: [], message: "No posts found. Follow more users to see their posts." }
      else
        { posts: posts, message: nil }
      end
    end

    # field [:search_users, [ Types::UserType]], null: true, description: "Search profile relative by username or email" do
    #   argument :email, String, required: false
    #   argument :username, String, required: false
    # end
    # def search_users(email:, username:)
    #   users = User.all
    #   users = users.where("email ILIKE ?", "%#{email}%") if email.present?
    #   users = users.where("username ILIKE ?", "%#{username}%") if username.present?
    #   return [] if users.empty?
    #   users
    # end
    field :search_users, [Types::UserType], null: true, description: "Search profile relative by username or email" do
      argument :search_param, String, required: true, description: "Search param"
    end

    def search_users(search_param:)
      users = User.all
      users = users.where("email ILIKE :search OR username ILIKE :search", search: "%#{search_param}%")
      users
    end
  end
end
