module Types
  class CommentType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :content, String, null: false
    field :user, Types::UserType, null: false
    field :post, Types::PostType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
