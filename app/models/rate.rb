# frozen_string_literal: true

# Model for exchange rates
class Rate < ApplicationRecord
  belongs_to :table_type
end
