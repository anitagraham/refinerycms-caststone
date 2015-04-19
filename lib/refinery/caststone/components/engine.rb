module Refinery
  module Caststone
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Caststone

      engine_name :refinery_caststone
      config.autoload_paths += %W( #{config.root}/lib )

      initializer 'attach-caststone-drawings-with-dragonfly', :before => :finisher_hook do |app|
        ::CaststoneDragonfly.configure!(:caststone_components)
        ::CaststoneDragonfly.attach!(app, :caststone_components)
      end

      def self.register_components(tab)
        tab.name = "components"
        tab.partial = "/refinery/caststone/admin/components/tabs/components"
      end

      before_inclusion do
         Refinery::Plugin.register do |plugin|
          plugin.name = "caststone_components"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.caststone_admin_components_path }
          plugin.pathname = root
          plugin.menu_match = %r{refinery/caststone/components(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Caststone::Components)
      end
    end
  end
end
