namespace :sources do
  desc "update api source files"
  task :update_external_sources => :environment do
    UpdateShipwireJob.perform_later
    UpdateShopifyJob.perform_later
  end
end
