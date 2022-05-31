# frozen_string_literal: true

class RemoveDefaultUserIdFromPostsComments < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :user_id, from: User.first.id, to: nil
    change_column_default :comments, :user_id, from: User.first.id, to: nil
  end
end
