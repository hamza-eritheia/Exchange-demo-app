# frozen_string_literal: true

# Background Job for collecting exchange rates
class CollectorJob < ApplicationJob
  queue_as :urgent

  include HTTParty
  BASE_URL = 'http://api.nbp.pl/api/'
  TABLE_TYPES = %w[A B C].freeze

  def perform
    TABLE_TYPES.each do |type|
      resp = HTTParty.get("#{BASE_URL}/exchangerates/tables/#{type}/").parsed_response[0]

      rates = resp.delete('rates')
      table_type = TableType.create(resp)
      table_type.rates.create(rates)
    end
  rescue => e
    puts "Job failed: #{e}"
  end
end
