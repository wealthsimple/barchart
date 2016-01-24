module Barchart
  class Resource

    def self.initialize_from_array_response(resource_class, response)
      JSON.parse(response.body).map do |resource_json|
        resource_class.new(resource_json)
      end
    end

    attr_reader :response_json

    def initialize(response)
      @response_json = convert_hash_keys(JSON.parse(response))[:results]
      @struct = RecursiveOpenStruct.new(@response_json, {recurse_over_arrays: true})
    end

    def as_json(options = {})
      @response_json
    end

    def method_missing(name, *args)
      @struct.send(name)
    end

  private

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

  end
end
