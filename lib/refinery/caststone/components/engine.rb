module Refinery
  module Caststone
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Caststone

      engine_name :refinery_caststone
      config.autoload_paths += %W( #{config.root}/lib )

      initializer 'attach-caststone-drawings-with-dragonfly', :after => :load_config_initializers do |app|
        ::Refinery::Caststone::Components::Dragonfly.configure!
        ::Refinery::Caststone::Components::Dragonfly.attach!(app)
      end

      def self.register_components(tab)
        tab.name = "components"
        tab.partial = "/refinery/caststone/admin/components/tabs/components"
      end

      initializer "register refinerycms_components plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "caststone_components"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.caststone_admin_components_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/caststone/component',
            :title => 'name'
          }
          plugin.menu_match = %r{refinery/caststone/components(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Components)
        # Register the components tab. We use this with the Photos definition
        # Refinery::Pages::Tab.register do |tab|
        # register_components tab
        # end
      end
    end
  end
end
