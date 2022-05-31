# frozen_string_literal: true

class RemoveAuthorFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :author
  end
end
