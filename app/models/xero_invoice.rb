class XeroInvoice < ActiveRecord::Base
  include MaxOrderUpdatedAt
end
