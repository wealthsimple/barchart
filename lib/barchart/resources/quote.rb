module Barchart
  # http://www.barchartondemand.com/api/getQuote
  class Quote < Resource
    # mode can be R (realtime), I (delayed), D (end-of-day)
    def self.get!(symbols, fields=[:bid,:ask], mode='R')
      fields_query = fields.join(',')

      symbols_query = symbols
      symbols_query = symbols.join(',')  if symbols.is_a?(Array)

      response = Request.get("/getQuote.json?symbols=#{symbols_query}&fields=#{fields_query}")

      return Quote.new(response[:results].first)  if symbols.is_a?(String)
      response[:results].map { |result| Quote.new(result) }
    end

  end
end
