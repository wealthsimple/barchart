module Barchart
  # http://www.barchartondemand.com/api/getEquityOptions
  # @param [Array<String>, String] underlying_symbols
  # @param [Hash] options
  # @option options [Array<String>] :fields
  # @option options [String] :type
  # @option options [Float] :strike_price
  # @option options [String] :expiration_month
  # @option options [Date] :expiration_date
  # @option options [Boolean] :only_strikes

  class EquityOptionsIntraday < Resource
    def self.get!(underlying_symbols, options = {})
      underlying_symbols_query = [
        "underlying_symbols", [underlying_symbols].flatten.join(',')
      ].join("=")

      fields_query = [
        "fields", [options[:fields]].flatten.join(',')
      ].join("=") if options[:fields]

      type_query = ["type", options[:type]].join("=") if options[:type]
      strike_price_query = ["strikePrice", options[:strike_price]].join("=") if options[:strike_price]
      expiration_month_query = ["expirationMonth", options[:expiration_month]].join("=") if options[:expiration_month]
      expiration_date_query = ["expirationDate", options[:expiration_date].strftime('%Y%m%d')].join("=") if options[:expiration_date]
      only_strikes_query = ["onlyStrikes", options[:only_strikes]].join("=") if options[:only_strikes]

      params = [
        underlying_symbols_query,
        fields_query,
        type_query,
        strike_price_query,
        expiration_month_query,
        expiration_date_query,
        only_strikes_query
      ].compact.join('&')

      response = Request.get("/getEquityOptionsIntraday.json?#{params}")

      response[:results].map do |result|
        EquityOptionsIntraday.new(result)
      end if response[:results].present?
    end
  end
end
