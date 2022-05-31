# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :log_obj, polymorphic: true
  belongs_to :user
end
