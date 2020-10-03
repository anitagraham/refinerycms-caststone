module Refinery
  module Caststone
    module Photos

      # extend Refinery::Dragonfly::ExtensionConfiguration
      include ActiveSupport::Configurable
      config_accessor :embed_start_date, :defined_views, :preferred_view

      self.embed_start_date = Date.strptime("20/09/2020", "%d/%m/%Y")
      self.defined_views = %i[grid list]
      self.preferred_view = :grid

    end
  end
end
