module Types
  class FollowType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :follower, Types::UserType, null: false
    field :followed, Types::UserType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end