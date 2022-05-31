# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
