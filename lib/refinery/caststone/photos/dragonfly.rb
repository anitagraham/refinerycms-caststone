require 'dragonfly'
require 'dragonfly/rails/images'
module Refinery
  module Caststone
      module Photos
         module Dragonfly
          class << self
            def setup!
              app_images = ::Dragonfly[:caststone_photos]
              app_images.configure_with(:imagemagick)
              app_images.analyser.register(::Dragonfly::ImageMagick::Analyser)
              app_images.analyser.register(::Dragonfly::Analysis::FileCommandAnalyser)

              app_images.define_macro(::Refinery::Caststone::Photo, :photo_accessor)
            end

            def configure!
              app_images = ::Dragonfly[:caststone_photos]
              # app_images.configure_with(:imagemagick)
              app_images.configure_with(:rails) do |c|
                c.datastore.root_path = Refinery::Caststone::Photos.datastore_root_path
                c.url_format = Refinery::Caststone::Photos.dragonfly_url_format
                c.secret = Refinery::Caststone::Photos.dragonfly_secret
                # c.trust_file_extensions = Refinery::Caststone::Photos.trust_file_extensions
              end


              if ::Refinery::Caststone::Photos.s3_backend
                app_images.datastore = ::Dragonfly::DataStorage::S3DataStore.new
                app_images.datastore.configure do |s3|
                  s3.bucket_name = Refinery::Caststone::Photos.s3_bucket_name
                  s3.access_key_id = Refinery::Caststone::Photos.s3_access_key_id
                  s3.secret_access_key = Refinery::Caststone::Photos.s3_secret_access_key
                  s3.region = Refinery::Caststone::Photos.s3_region if Refinery::Caststone::Photos.s3_region
                end
              end
            end

            def attach!(app)
              ### Extend active record ###
              app.config.middleware.insert_before Refinery::Resources.dragonfly_insert_before,
                                                  'Dragonfly::Middleware', :caststone_photos

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
