# frozen_string_literal: true

class Post < ApplicationRecord
  has_one_attached :avatar
  include LogObj
  belongs_to :user

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }

  has_many :comments, dependent: :destroy
end
