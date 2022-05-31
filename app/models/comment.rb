# frozen_string_literal: true

class Comment < ApplicationRecord
  include LogObj
  belongs_to :post
  belongs_to :user

  validates :body, presence: true, length: { minimum: 2 }
end
