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
      @params = params['resource']
    end

    def id
      params['id']
    end

    def to_json
      params.to_json
    end

    private

    def params
      @params
    end
  end
end
