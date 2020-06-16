module Refinery
  module Caststone
    module Components

      extend Refinery::Dragonfly::ExtensionConfiguration
      include ActiveSupport::Configurable

      # config settings related to images/app interface
      config_accessor :permitted_mime_types,
                      :defined_views, :preferred_view
      
      config.dragonfly_plugin = :imagemagick
      config.dragonfly_name = :caststone_components
      config.dragonfly_url_format = '/system/refinery/drawings/:job/:basename.:ext'
      config.whitelisted__mime_types = %w['image/png', 'image/svg']

      self.defined_views = [:grid, :list]
      self.preferred_view = :grid

    end
  end
end
