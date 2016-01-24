module Barchart
  # http://www.barchartondemand.com/api/getQuote
  class Quote < Resource
    # mode can be R (realtime), I (delayed), D (end-of-day)
    def self.get!(symbol, fields=[:bid,:ask], mode='R')
      fields_query = fields.join(',')
      response = Request.get("/getQuote.json?symbols=#{symbol}&fields=#{fields_query}")
      p response
      Quote.new(response)
    end

  end
end
