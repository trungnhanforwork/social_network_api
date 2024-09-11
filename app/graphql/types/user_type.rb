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

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
  def profile_image_url
    object.profile_image.attached? ? Rails.application.routes.url_helpers.rails_blob_url(object.profile_image, only_path: true) : nil
  end
end