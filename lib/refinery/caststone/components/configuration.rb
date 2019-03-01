module Refinery
  module Caststone
    module Components

      extend Refinery::Dragonfly::ExtensionConfiguration
      include ActiveSupport::Configurable

      # config settings related to images/app interface
      config_accessor :captions,
                      :whitelisted_mime_types,
                      :defined_views, :preferred_view

      config.captions = true
      config.dragonfly_name = :components
      config.dragonfly_plugin = :imagemagick
      config.dragonfly_insert_before = 'ActionDispatch::Callbacks'
      config.dragonfly_secret = Refinery::Dragonfly.secret
      config.dragonfly_trust_file_extensions = true
      config.dragonfly_allow_fetch_file = true
      config.dragonfly_protect_from_dos_attacks = true
      config.dragonfly_url_format = '/system/refinery/drawings/:job/:basename.:ext'

      config.whitelisted__mime_types = %w['image/png']

      self.defined_views = [:grid, :list]
      self.preferred_view = :grid

      # We have to configure these settings after Rails is available.
      # But a non-nil custom option can still be provided
      class << self

        def dragonfly_custom_datastore?
          false
        end

        def datastore_root_path
          config.datastore_root_path || (Rails.root.join('public', 'system', 'refinery/images').to_s if Rails.root)
        end

        def s3_backend
          config.s3_backend.nil? ? Refinery::Dragonfly.s3_backend : config.s3_backend
        end

        def s3_bucket_name
          config.s3_bucket_name.nil? ? Refinery::Dragonfly.s3_bucket_name : config.s3_bucket_name
        end

        def s3_access_key_id
          config.s3_access_key_id.nil? ? Refinery::Dragonfly.s3_access_key_id : config.s3_access_key_id
        end

        def s3_secret_access_key
          config.s3_secret_access_key.nil? ? Refinery::Dragonfly.s3_secret_access_key : config.s3_secret_access_key
        end

        def s3_region
          config.s3_region.nil? ? Refinery::Dragonfly.s3_region : config.s3_region
        end

      end

    end
  end
end
