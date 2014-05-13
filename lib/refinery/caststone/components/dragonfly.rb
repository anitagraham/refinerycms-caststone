require 'dragonfly'

module Refinery
  module Caststone
      module Components
        module Dragonfly
          class << self
            def setup!
              app_images = ::Dragonfly[:caststone_drawings]
              app_images.configure_with(:imagemagick)
    
              app_images.analyser.register(::Dragonfly::ImageMagick::Analyser)
              app_images.analyser.register(::Dragonfly::Analysis::FileCommandAnalyser)

              app_images.define_macro(::Refinery::Caststone::Component, :drawing_accessor)
            end

            def configure!
              app_images = ::Dragonfly[:caststone_drawings]
              app_images.configure_with(:rails) do |c|
                c.datastore.root_path = Refinery::Caststone::Components.datastore_root_path
                c.url_format = Refinery::Caststone::Components.dragonfly_url_format
                c.secret = Refinery::Caststone::Components.dragonfly_secret
                # c.trust_file_extensions = Refinery::Caststone::Components.trust_file_extensions
              end
    
              if ::Refinery::Caststone::Components.s3_backend
                app_images.datastore = ::Dragonfly::DataStorage::S3DataStore.new
                app_images.datastore.configure do |s3|
                  s3.bucket_name = Refinery::Caststone::Components.s3_bucket_name
                  s3.access_key_id = Refinery::Caststone::Components.s3_access_key_id
                  s3.secret_access_key = Refinery::Caststone::Components.s3_secret_access_key
                  s3.region = Refinery::Caststone::Components.s3_region if Refinery::Caststone::Components.s3_region
                end
              end
            end

            def attach!(app)
              ### Extend active record ###
              app.config.middleware.insert_before Refinery::Resources.dragonfly_insert_before,
                                                  'Dragonfly::Middleware', :caststone_drawings
    
              app.config.middleware.insert_before 'Dragonfly::Middleware', 'Rack::Cache', {
                :verbose     => Rails.env.development?,
                :metastore   => "file:#{Rails.root.join('tmp', 'dragonfly', 'cache', 'meta')}",
                :entitystore => "file:#{Rails.root.join('tmp', 'dragonfly', 'cache', 'body')}"
              }
            end 
         end
      end
    end
  end
end
