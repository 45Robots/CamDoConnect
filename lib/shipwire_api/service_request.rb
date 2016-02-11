require 'faraday'

module ShipwireAPI
  class ServiceRequest
    attr_reader :response, :errors, :next_url

    def initialize
      @errors = []
    end

    def get(url: ShipwireAPI.endpoint + resource_name, since: nil, limit: 100)
      begin
        connection = Faraday.new(url: url) do |faraday|
          faraday.request :url_encoded
          faraday.params['limit'] = limit
          faraday.params['updatedAfter'] = since.utc.iso8601 if since.present?
          faraday.authorization "Basic", ShipwireAPI.authorization
          faraday.adapter Faraday.default_adapter
        end
        @response = connection.get
        @next_url = body['resource']['next']
      rescue Faraday::ConnectionFailed
        @errors << 'Unable to connect to Shipwire'
      rescue
        @errors << 'Unknown error'
      end
    end

    def next_page
      return if @next_url.nil?
      get(url: next_url)
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

    def resource
      body['resource']
    end
  end
end
