module Refinery
  module Caststone
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Caststone

      engine_name :refinery_caststone

      initializer "register refinerycms_products plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "caststone.products"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.caststone_admin_products_path }
          plugin.pathname = root
          plugin.menu_match = %r{refinery/caststone/products(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Caststone::Products)
      end
    end
  end
end
