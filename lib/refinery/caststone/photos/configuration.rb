module Refinery
  module Caststone
    module Photos
      include ActiveSupport::Configurable

      config_accessor :captions, :sizes, :dragonfly_insert_before, :dragonfly_secret, :dragonfly_url_format,
                      :dragonfly_datastore_root_path, :whitelisted_mime_types, :dragonfly_trust_file_extensios,
                      :dragonfly_allow_fetch_file, :dragonfly_protect_from_dos_attacks,
                      :s3_backend, :s3_bucket_name, :s3_region,
                      :s3_access_key_id, :s3_secret_access_key 


      config.dragonfly_insert_before = 'ActionDispatch::Callbacks'
      config.dragonfly_secret = Refinery::Core.dragonfly_secret
      config.dragonfly_url_format = '/system/refinery/images/:job/:basename.:ext'
      config.whitelisted_mime_types = %w[image/jpg]
      config.sizes = {
        :home => '673x380!',
        :pillars => '640x425>',
        :columns => '890x600>',
        :letterboxes => '700x400>',
        :edit => '500x500',
        :mini => 'x100'
      }

      config.captions = true
      config.s3_backend = Refinery::Core.s3_backend

      class << self
        def datastore_root_path
          config.datastore_root_path ||  (Rails.root.join('public', 'system', 'refinery/images').to_s if Rails.root)
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

      end
      
    end
  end
end
