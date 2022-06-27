# frozen_string_literal: true

namespace :collect_exchange_rate do
  desc 'Collection exchange rate of all currencies'
  task monthly: :environment do
    start_date = Date.today.at_beginning_of_month.strftime('%Y-%m-%d')
    end_date = Date.today.strftime('%Y-%m-%d')
    CollectorJob.perform_now(start_date, end_date)
  end
end
