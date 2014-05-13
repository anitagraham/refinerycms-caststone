module Refinery
  module Caststone
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Caststone

      engine_name :refinery_caststone

      config.autoload_paths += %W( #{config.root}/lib )

      initializer 'attach-caststone-photos-with-dragonfly', :after => :load_config_initializers do |app|
        ::Refinery::Caststone::Photos::Dragonfly.configure!
        ::Refinery::Caststone::Photos::Dragonfly.attach!(app)
      end


      def self.register_photos(tab)
        tab.name = "photos"
        tab.partial = "/refinery/caststone/admin/photos/tabs/photos"
      end

      initializer "register refinerycms_photos plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "photos"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.caststone_admin_photos_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/caststone/photo',
            :title => 'name'
          }
          plugin.menu_match = %r{refinery/caststone/photos(/.*)?$}
        end
      end
      config.to_prepare do
        require 'refinerycms-pages'
        Refinery::Page.send :photo_relationships
      end
       config.after_initialize do

        Refinery::Pages::Tab.register do |tab|
          register_photos tab
        end

        Refinery.register_extension(Refinery::Photos)
      end
    end
  end
end
