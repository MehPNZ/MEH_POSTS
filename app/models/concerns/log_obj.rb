# frozen_string_literal: true

module LogObj
  extend ActiveSupport::Concern

  included do
    # rubocop:disable Rails/HasManyOrHasOneDependent
    has_many :logs, as: :log_obj
    # rubocop:enable Rails/HasManyOrHasOneDependent
  end
end
