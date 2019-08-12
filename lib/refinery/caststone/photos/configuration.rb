module Refinery
  module Caststone
    module Photos

      extend Refinery::Dragonfly::ExtensionConfiguration
      include ActiveSupport::Configurable

      config_accessor :captions,
                      :max_image_size,
                      :pages_per_dialog,
                      :pages_per_admin_index,
                      :pages_per_dialog_that_have_size_options,
                      :sizes,
                      :defined_views,
                      :preferred_view,
                      :whitelisted_mime_types

      config.captions = true
      config.dragonfly_name = :caststone_photos
      config.dragonfly_plugin = :imagemagick
      self.dragonfly_url_format = '/system/refinery/photos/:job/:basename.:ext'
      self.whitelisted_mime_types = %w[image/jpeg image/png image/gif image/tiff]

      self.max_image_size = 5242880
      self.pages_per_dialog = 18
      self.pages_per_dialog_that_have_size_options = 12
      self.pages_per_admin_index = 20
      self.sizes = {
#        % Interpret width and height as a percentage of the current size.
#        ! Resize to width and height exactly, loosing original aspect ratio.
#        < Resize only if the image is smaller than the geometry specification.
#        > Resize only if the image is greater than the geometry specificatio
        home: '980x680!',
        pillars: '780x520>',
        columns: '890x600>',
        letterboxes: '700x400>',
        trim: '640x425>',
        edit: '500x500',
        small: '480x644',
        mini: 'x100',
        photowallThumb: 'x150'
      }

    self.defined_views = [:photos, :list]
    self.preferred_view = :photos

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
