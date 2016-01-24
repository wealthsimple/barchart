module Barchart
  class Resource

    def self.initialize_from_array_response(resource_class, response)
      JSON.parse(response.body).map do |resource_json|
        resource_class.new(resource_json)
      end
    end

    attr_reader :response_json, :struct

    def initialize(response)
      @response_json = response
      @struct = RecursiveOpenStruct.new(@response_json, {recurse_over_arrays: true})
    end

    def as_json(options = {})
      @response_json
    end

    def method_missing(name, *args)
      @struct[name.to_sym]
    end

    def inspect
      @struct.inspect.gsub(/#<RecursiveOpenStruct/,"#<#{self.class.name}")
    end

  end
end
