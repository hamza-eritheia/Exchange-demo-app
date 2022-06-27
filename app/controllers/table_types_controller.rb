# frozen_string_literal: true

# Table types controller class
class TableTypesController < ApplicationController
  include TableTypeConcern

  before_action :set_dates, only: [:exchange_rates]

  def exchange_rates
    return render json: ['Invalid Date Range'] unless valid_date?(@start_date, @end_date)

    rates = TableType.includes(:rates).where(effectiveDate: @start_date..@end_date, 'rates.code': params[:currency])
    rates_average = rates_avg(rates)

    respond_to do |format|
      format.json do
        render json: { rates: TableTypeSerializer.new(rates), rates_avg: rates_average }
      end
      format.csv do
        send_data render_csv(rates, rates_average), type: 'text/plain', filename: 'exchange_rates.csv', disposition: 'attachment'
      end
    end
  end

  private

  def set_dates
    @start_date = params[:start_date] || Date.today.strftime('%Y-%m-%d')
    @end_date = params[:end_date] || Date.today.strftime('%Y-%m-%d')
  end
end
