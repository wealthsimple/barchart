module Barchart
  class Request
    attr_reader :method, :path, :body

    def initialize(method:, path:, body: nil)
      Barchart.configuration.validate!
      @method = method
      @path = path
      @body = body
    end

    # Define class methods for more succinct requests
    %i(get post put delete head patch).each do |http_method|
      define_singleton_method(http_method) do |path, body=nil|
        Request.new(method: http_method, path: path, body: body).execute
      end
    end

    def execute
      p url
      response = RestClient::Request.new({
        url: url,
        method: method,
        headers: {
          'Content-Type': 'application/json',
          'Date': Time.now.utc.httpdate,
        },
        payload: body_to_json,
      }).execute

      convert_hash_keys(JSON.parse(response))
    end

  private

    def url
      base_url = Barchart.configuration.api_base_url
      base_url += "/"  unless base_url.end_with?("/")
      base_url += path.sub(%r{^/}, '')

      base_url += path =~ /\?/ ? '&' : '?'
      base_url += "apikey=#{Barchart.configuration.api_key}"
      base_url
    end

    def underscore_key(k)
      k.to_s.underscore.to_sym
    end

    def convert_hash_keys(value)
      case value
      when Array then value.map { |v| convert_hash_keys(v) }
      when Hash then Hash[value.map { |k, v| [underscore_key(k), convert_hash_keys(v)] }]
      else value
      end
    end

    def body_to_json
      if body
        body.is_a?(String) ? body : body.to_json
      else
        nil
      end
    end
  end
end
