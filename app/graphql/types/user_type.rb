module Types
  class UserType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :username, String, null: false
    field :email, String, null: false
    field :posts, [Types::PostType], null: true
    field :comments, [Types::CommentType], null: true

    field :followers, [Types::UserType], null: true
    field :following, [Types::UserType], null: true

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end