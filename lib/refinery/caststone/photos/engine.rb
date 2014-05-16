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

      initializer "register refinery_caststone_photos plugin" do
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

      config.after_initialize do
        Refinery.register_extension(Refinery::Caststone::Photos)
        Refinery::Pages::Tab.register do |tab|
          register_testimonials tab
        end
      end

    end
  end
end
