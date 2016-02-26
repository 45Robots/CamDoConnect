module MaxOrderUpdatedAt
  extend ActiveSupport::Concern

  class_methods do 
    def most_recent_updated_at
      maximum(:order_updated_at)
    end
  end
end
