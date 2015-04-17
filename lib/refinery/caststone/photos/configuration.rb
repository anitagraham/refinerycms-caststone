module Refinery
  module Caststone
    module Photos
      include ActiveSupport::Configurable

      config_accessor :captions,
                    :dragonfly_insert_before, :dragonfly_secret, :dragonfly_url_format, :dragonfly_url_host,
                    :max_image_size, :pages_per_dialog, :pages_per_admin_index,
                    :pages_per_dialog_that_have_size_options, :sizes,
                    :image_views, :preferred_image_view, :datastore_root_path,
                    :s3_backend, :s3_bucket_name, :s3_region,
                    :s3_access_key_id, :s3_secret_access_key, :trust_file_extensions,
                    :whitelisted_mime_types,
                    :custom_backend_class, :custom_backend_opts

      self.dragonfly_insert_before = 'ActionDispatch::Callbacks'
      self.dragonfly_secret = Refinery::Core.dragonfly_secret
      self.dragonfly_url_format = '/system/refinery/images/:job/:basename.:ext'
      self.dragonfly_url_format = '/system/images/:job/:basename.:ext'
      self.dragonfly_url_host = ''
      self.trust_file_extensions = false
      self.whitelisted_mime_types = %w[image/jpeg image/png image/gif image/tiff]

      self.image_views = [:grid, :list]
      self.preferred_image_view = :grid

      self.max_image_size = 5242880
      self.pages_per_dialog = 18
      self.pages_per_dialog_that_have_size_options = 12
      self.pages_per_admin_index = 20
      self.sizes = {
        :home => '960x690!',
        :pillars => '640x425>',
        :columns => '890x600>',
        :letterboxes => '700x400>',
        :edit => '500x500',
        :mini => 'x100'
      }

      config.captions = true

    # We have to configure these settings after Rails is available.
    # But a non-nil custom option can still be provided
      class << self
        def datastore_root_path
          config.datastore_root_path || (Rails.root.join('public', 'system', 'refinery', 'images').to_s if Rails.root)
        end

        def s3_backend
          config.s3_backend.presence || Core.s3_backend
        end

        def s3_bucket_name
          config.s3_bucket_name.presence || Core.s3_bucket_name
        end

        def s3_access_key_id
          config.s3_access_key_id.presence || Core.s3_access_key_id
        end

        def s3_secret_access_key
          config.s3_secret_access_key.presence || Core.s3_secret_access_key
        end

        def s3_region
          config.s3_region.presence || Core.s3_region
        end

        def custom_backend?
          config.custom_backend_class.nil? ? Core.dragonfly_custom_backend? : config.custom_backend_class.present?
        end

        def custom_backend_class
          config.custom_backend_class.nil? ? Core.dragonfly_custom_backend_class : config.custom_backend_class.constantize
        end

        def custom_backend_opts
          config.custom_backend_opts.presence || Core.dragonfly_custom_backend_opts
        end
      end
    end
  end
end
