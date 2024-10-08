module Types
  class UserType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :username, String, null: false
    field :email, String, null: false
    field :posts, [Types::PostType], null: true
    field :comments, [Types::CommentType], null: true
    field :profile_image_url, String, null: true

    field :followers, [Types::UserType], null: true
    field :following, [Types::UserType], null: true

    field :following_count, Integer, null: false
    field :followers_count, Integer, null: false

    field :reset_password_token, String, null: true
    field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime, null: true

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def following_count
      object.following.count
    end

    def followers_count
      object.followers.count
    end

    def profile_image_url
      object.profile_image_url
    end
  end
end