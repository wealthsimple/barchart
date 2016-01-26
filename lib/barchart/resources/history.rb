module Barchart
  # http://www.barchartondemand.com/api/getHistory

  # The getHistory API is used to request historical time series data on stocks,
  # indices, mutual funds, ETFs, futures, indices or forex pairs.
  # Historical data is available as tick, minute or end-of-day data.


  class History < Resource
    # see the API documentation for values for type
    def self.get!(symbol, start_date=Date.today, end_date=nil, type='daily')

      start_date_query = "startDate=#{start_date.strftime('%Y%m%d')}"  if start_date
      end_date_query = "endDate=#{end_date.strftime('%Y%m%d')}"  if end_date
      symbol_query = "symbol=#{symbol}"
      type_query = "type=#{type}"

      params = [symbol_query, type_query, start_date_query, end_date_query].compact.join('&')
      response = Request.get("/getHistory.json?#{params}")

      response[:results].andand.map { |result| History.new(result) }
    end
  end
end
