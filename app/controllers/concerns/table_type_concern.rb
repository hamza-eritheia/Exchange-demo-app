# frozen_string_literal: true

# Concern for Table types
module TableTypeConcern
  extend ActiveSupport::Concern

  def valid_date?(start_date, end_date)
    start_date <= end_date
  end

  def rates_avg(rates)
    sum = 0

    rates.each do |rate|
      rate = rate.rates[0]
      sum += (rate.mid || rate.bid || rate.ask).to_i
    end

    sum / rates.count
  end

  def render_csv(table_rates, avg)
    header     = %W[Average #{avg}]
    attributes = %w[effectiveDate currency code mid bid ask]

    CSV.generate(headers: true) do |row|
      row << header
      row << attributes

      table_rates.each do |table_rate|
        row << attributes.map do |attr|
          if attr == 'effectiveDate'
            table_rate.send('effectiveDate')
          else
            table_rate.rates[0].send(attr)
          end
        end
      end
    end
  end
end
