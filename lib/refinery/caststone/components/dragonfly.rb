require 'dragonfly'
module Refinery
  module Caststone
    module Components
      module Dragonfly
        class << self
          def configure!
            ActiveRecord::Base.extend ::Dragonfly::Model
            ActiveRecord::Base.extend ::Dragonfly::Model::Validations

            app = ::Dragonfly.app(:caststone_drawings)

            app.configure do
              plugin :imagemagick
              datastore :file, {
                :root_path => Refinery::Caststone::Components.datastore_root_path
              }
              url_host Refinery::Caststone::Components.dragonfly_url_host
              secret Refinery::Caststone::Components.dragonfly_secret
              dragonfly_url nil
              processor :strip do |content|
                content.process!(:convert, '-strip')
              end
            end

            if ::Refinery::Caststone::Photos.s3_backend
              require 'dragonfly/s3_data_store'
              options = {
                bucket_name: Refinery::Caststone::Photos.s3_bucket_name,
                access_key_id: Refinery::Caststone::Photos.s3_access_key_id,
                secret_access_key: Refinery::Caststone::Photos.s3_secret_access_key
              }
              # S3 Region otherwise defaults to 'us-east-1'
              options.update(region: Refinery::Caststone::Photos.s3_region) if Refinery::Caststone::Photos.s3_region
              apps.use_datastore :s3, options
            end

            if Refinery::Caststone::Components.custom_backend?
              app.datastore = Refinery::Caststone::Components.custom_backend_class.new(Refinery::Caststone::Components.custom_backend_opts)
            end
          end

          ##
          # Injects Dragonfly::Middleware for Caststone::Components into the stack
          def attach!(app)
            if defined?(::Rack::Cache)
              unless app.config.action_controller.perform_caching && app.config.action_dispatch.rack_cache
                app.config.middleware.insert 0, ::Rack::Cache, {
                  verbose: false,
                  metastore: URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/meta"), # URI encoded in case of spaces
                  entitystore: URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/body")
                }
              end
              app.config.middleware.insert_after ::Rack::Cache, ::Dragonfly::Middleware, :caststone_drawings
            else
              app.config.middleware.use ::Dragonfly::Middleware, :caststone_drawings
            end
          end
        end
      end
    end
  end
end