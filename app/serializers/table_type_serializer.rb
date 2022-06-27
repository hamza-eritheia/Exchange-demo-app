# frozen_string_literal: true

# Serializer for TableType model
class TableTypeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :table, :effectiveDate, :rates
end
