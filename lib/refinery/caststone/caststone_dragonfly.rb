require 'dragonfly'

module CaststoneDragonfly
  class << self
    def configure!(app_name, url_segment='images')
      ActiveRecord::Base.extend ::Dragonfly::Model
      ActiveRecord::Base.extend ::Dragonfly::Model::Validations

      app = ::Dragonfly.app(app_name)

      # Use Refinery::Core configuration settings
      app.configure do
        plugin :imagemagick
        datastore :file, {
          :root_path => Refinery::Images.datastore_root_path
        }
        url_host   Refinery::Images.dragonfly_url_host
        url_format "/system/refinery/#{url_segment}/:job/:basename.:ext"
        secret     Refinery::Images.dragonfly_secret
        dragonfly_url nil

        define_url do | app, job, opts|
			    thumb = Refinery::Caststone::Thumb.find_by_signature(job.signature)
			    if thumb
			      app.datastore.url_for(thumb.uid)
			    else
			      app.server.url_for(job)
			    end
			  end
			  # Before serving from the local Dragonfly server...

			  before_serve do |job, env|
			    uid = job.store
			    Refinery::Caststone::Thumb.create!(uid: uid, signature: job.signature)
			  end
      end

      if ::Refinery::Core.s3_backend
        require 'dragonfly/s3_data_store'
        options = {
          bucket_name: Refinery::Core.s3_bucket_name,
          access_key_id: Refinery::Core.s3_access_key_id,
          secret_access_key: Refinery::Core.s3_secret_access_key,
          url_scheme: :https
        }
        # S3 Region otherwise defaults to 'us-east-1'
        options.update(region: Refinery::Core.s3_region) if Refinery::Core.s3_region
        app.use_datastore :s3, options
      end

      # Logger
      Dragonfly.logger = Rails.logger

      if ::Refinery::Images.custom_backend?
        app.datastore = Images.custom_backend_class.new(Images.custom_backend_opts)
      end
    end


    # Injects Dragonfly::Middleware into the stack
    def attach!(app, app_name)
      if defined?(::Rack::Cache)
        unless app.config.action_controller.perform_caching && app.config.action_dispatch.rack_cache
          app.config.middleware.insert 0, ::Rack::Cache, {
            verbose: false,
            metastore: URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/meta"), # URI encoded in case of spaces
            entitystore: URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/body")
          }
        end
        app.config.middleware.insert_after ::Rack::Cache, ::Dragonfly::Middleware, app_name
      else
        app.config.middleware.use ::Dragonfly::Middleware, app_name
      end
    end
  end
end
