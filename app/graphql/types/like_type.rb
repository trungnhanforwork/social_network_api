module Types
  class LikeType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :user, Types::UserType, null: false
    field :post, Types::PostType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end