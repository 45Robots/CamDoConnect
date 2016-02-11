require "base64"

require 'shipwire_api/version'
require 'shipwire_api/configuration'

require 'shipwire_api/service_request'
require 'shipwire_api/order'

module ShipwireAPI
  class << self
    attr_accessor :configuration

    def configure(&block)
      @configuration = Configuration.new(&block)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def endpoint
      configuration.endpoint
    end

    def authorization
      configuration.authorization
    end

  end
end
