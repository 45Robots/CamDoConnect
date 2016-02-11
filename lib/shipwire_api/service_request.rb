require 'faraday'

module ShipwireAPI
  class ServiceRequest
    attr_reader :response, :errors

    def initialize
      @errors = []
    end

    def get
      begin
        connection = Faraday.new(url: ShipwireAPI.endpoint + resource_name) do |faraday|
          faraday.request :url_encoded
          faraday.authorization "Basic", ShipwireAPI.authorization
          faraday.adapter Faraday.default_adapter
        end

        @response = connection.get
      rescue Faraday::ConnectionFailed
        @errors << 'Unable to connect to Shipwire'
      rescue
        @errors << 'Unknown error'
      end
    end

    def is_ok?
      @response && @response.status == 200
    end

    def body
      return unless is_ok?
      JSON.parse(@response.body)
    end

    protected
    def build_payload
      raise 'Override this'
    end

    def resource_name
      raise 'Override this'
    end
  end
end
