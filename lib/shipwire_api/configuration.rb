module ShipwireAPI
  class Configuration
    attr_accessor :endpoint, :authorization

    def initialize(&block)
      block.call(self)
    end
  end
end
