module Refinery
  module Caststone
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Caststone

      engine_name :refinery_caststone

      config.after_initialize do
        tabs = [
          { title: 'Description',      partial: 'visual_editor_text', fields: :description },
          { title: 'Summary',          partial: 'visual_editor_text', fields: :summary },
          { title: 'Features',         partial: 'visual_editor_text', fields: :features },
          { title: 'Measurements',     partial: 'visual_editor_text', fields: :measurements },
          { title: 'Image & Drawing',  partial: 'drawing', fields: [:drawing, :image] },
          { title: 'Brochure',         partial: 'brochure', fields: [:brochure, :brochure_cover] },
          { title: 'Photos',           partial: 'product_photos', fields: :photos },
          { title: 'SEO',              partial: 'seo' },
          { title: 'Components',       partial: 'components', fields: :components }
        ]

        tabs.each do |t|
          Refinery::Caststone::Products::Tab.register do |tab|
            tab.name = t[:title]
            tab.partial = "/refinery/caststone/admin/products/tabs/#{t[:partial]}"
            tab.fields = t[:fields]
          end
        end
      end

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
