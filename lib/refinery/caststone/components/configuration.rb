module Refinery
  module Caststone
    module Components
      include ActiveSupport::Configurable

      config_accessor :captions, :dragonfly_insert_before, :dragonfly_secret, :dragonfly_url_format,
                      :dragonfly_datastore_root_path, :whitelisted_mime_types, :dragonfly_trust_file_extensios,
                      :dragonfly_allow_fetch_file, :dragonfly_protect_from_dos_attacks,
                      :s3_backend, :s3_bucket_name, :s3_region,
                      :s3_access_key_id, :s3_secret_access_key

      config.captions = true
      config.dragonfly_insert_before = 'ActionDispatch::Callbacks'
      config.dragonfly_secret = Refinery::Core.dragonfly_secret
      config.dragonfly_trust_file_extensions = true
      config.dragonfly_allow_fetch_file = true
      config.dragonfly_protect_from_dos_attacks = true
      config.whitelisted_mime_types = %w[image/png]
      config.dragonfly_url_format = '/system/refinery/drawings/:job/:basename.:ext'


      # We have to configure these settings after Rails is available.
      # But a non-nil custom option can still be provided
      class << self
        def datastore_root_path
          config.datastore_root_path || (Rails.root.join('public', 'system', 'refinery/images').to_s if Rails.root)
        end
      def s3_backend
        config.s3_backend.nil? ? Refinery::Core.s3_backend : config.s3_backend
      end

      def s3_bucket_name
        config.s3_bucket_name.nil? ? Refinery::Core.s3_bucket_name : config.s3_bucket_name
      end

      def s3_access_key_id
        config.s3_access_key_id.nil? ? Refinery::Core.s3_access_key_id : config.s3_access_key_id
      end

      def s3_secret_access_key
        config.s3_secret_access_key.nil? ? Refinery::Core.s3_secret_access_key : config.s3_secret_access_key
      end

      def s3_region
        config.s3_region.nil? ? Refinery::Core.s3_region : config.s3_region
      end

      end

    end
  end
end
