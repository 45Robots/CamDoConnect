module ShipwireAPI
  class Orders < ServiceRequest

    def orders
      @orders ||= begin
                    orders = []
                    get
                    orders << body['resource']['items']
                    while next_url
                      next_page
                      orders << body['resource']['items']
                    end
                    orders.flatten.map {|o| Order.new(o)}
                  end
    end


    protected

    def resource_name
      'orders'
    end
  end

  class Order
    def initialize(params)
      @params = params
    end

    private

    def params
      @params
    end
  end
end
