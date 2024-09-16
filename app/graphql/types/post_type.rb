module Types
  class PostType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :content, String, null: false
    field :comments, [ Types::CommentType ], null: true
    field :user, Types::UserType, null: false
    field :likes_count, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def likes_count
      object.likes.count
    end
  end
end