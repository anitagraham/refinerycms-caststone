module Refinery
  module Caststone
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Caststone

      engine_name :refinery_caststone
      config.autoload_paths += %W( #{config.root}/lib )


      initializer 'attach-caststone-photos-with-dragonfly', :before => :finisher_hook do |app|
        ::Refinery::Dragonfly.configure!(::Refinery::Caststone::Photos)
        ::Refinery::Dragonfly.attach!(app, ::Refinery::Caststone::Photos)
      end

      def self.register_photos(tab)
        tab.name = 'photos'
        tab.partial = '/refinery/caststone/admin/photos/tabs/photos'
      end

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "caststone.photos"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.caststone_admin_photos_path }
          plugin.pathname = root
          plugin.menu_match = %r{refinery/caststone/photos(/.*)?$}
        end
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
