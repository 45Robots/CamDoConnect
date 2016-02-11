module ShipwireAPI
  class Order < ServiceRequest

    protected

    def resource_name
      'orders'
    end
  end
end
