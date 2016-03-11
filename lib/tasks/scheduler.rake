namespace :sources do
  desc "update api source files"
  task :update_external_sources => :environment do
    UpdateShipwireJob.perform_later
    UpdateShopifyJob.perform_later
    UpdateXeroJob.perform_later
    CombinedOrder.older_than([Time.now.change(year: 2016, month: 1, day: 1, hour: 0), Time.now.last_year].max).each {|o| o.destroy}
    CombinedOrder.refresh
  end
end
