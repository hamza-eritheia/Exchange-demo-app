# frozen_string_literal: true

# Background Job for collecting exchange rates
class CollectorJob < ApplicationJob
  queue_as :urgent

  include HTTParty

  BASE_URL = 'http://api.nbp.pl/api'
  TABLE_TYPES = %w[A B C].freeze
  NOT_FOUND_ERROR = '404 NotFound'

  def perform(start_date = '', end_date = '')
    start_date, end_date = set_dates if start_date == '' || end_date == ''

    TABLE_TYPES.each do |type|
      resp = HTTParty.get("#{BASE_URL}/exchangerates/tables/#{type}/#{start_date}/#{end_date}").parsed_response
      next if resp.include?(NOT_FOUND_ERROR)

      save_in_db(resp)
    end
  rescue StandardError => e
    puts "Job failed: #{e}"
  end

  def set_dates
    start_date = last_db_date || Date.today.strftime('%Y-%m-%d')
    end_date = Date.today.strftime('%Y-%m-%d')

    [start_date, end_date]
  end

  def last_db_date
    last_date = TableType.last&.effectiveDate&.to_date
    return last_date if last_date.blank?

    (last_date + 1.day).strftime('%Y-%m-%d')
  end

  def save_in_db(responses)
    responses.each do |resp|
      rates = resp.delete('rates')
      table_type = TableType.create(resp)
      table_type.rates.create(rates)
    end
  end
end
