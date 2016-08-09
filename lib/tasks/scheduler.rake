namespace :sources do
  desc "update api source files"
  task :update_external_sources => :environment do
    UpdateShipwireJob.perform_later
    UpdateShopifyJob.perform_later
    UpdateXeroJob.perform_later
    CombinedOrder.older_than(Time.now - 6.months).each {|o| o.destroy}
    CombinedOrder.refresh
  end
end
