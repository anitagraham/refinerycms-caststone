module Refinery
  module Caststone
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Caststone

      engine_name :refinery_caststone

      config.autoload_paths += %W( #{config.root}/lib )

      def self.register_photos(tab)
        tab.name = 'photos'
        tab.partial = '/refinery/caststone/admin/photos/tabs/photos'
      end

      initializer 'attach-caststone-photos-with-dragonfly', :after => :load_config_initializers do |app|
        ::Refinery::Caststone::Photos::Dragonfly.configure!
        ::Refinery::Caststone::Photos::Dragonfly.attach!(app)
      end

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "caststone_photos"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.caststone_admin_photos_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => Refinery::Caststone::Photo,
            :title => 'name'
          }
        end
      end
      config.to_prepare do
        require 'refinerycms-pages'
        Refinery::Page.send :has_many_photos
        # Refinery::Blog::Post.send :has_many_photos, class_name: "Refinery::Caststone::Photo" if defined?(::Refinery::Blog)
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Caststone::Photos)
        Refinery::Pages::Tab.register do |tab|
          register_photos tab
        end
      end

    end
  end
end
