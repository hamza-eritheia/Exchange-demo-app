# frozen_string_literal: true

# Model for table types
class TableType < ApplicationRecord
  has_many :rates, dependent: :destroy
end
