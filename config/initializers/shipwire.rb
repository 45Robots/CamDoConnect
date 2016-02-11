require 'shipwire_api'

ShipwireAPI.configure do |config|
  config.endpoint = ENV['SHIPWIRE_ENDPOINT']
  config.authorization = ENV['SHIPWIRE_AUTHORIZATION']
end
