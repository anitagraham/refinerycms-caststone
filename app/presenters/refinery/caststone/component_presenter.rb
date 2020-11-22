module Refinery
  module Caststone
    class ComponentPresenter < Refinery::BasePresenter
      include ActiveSupport::Configurable
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::AssetTagHelper
      include ActionView::Helpers::TranslationHelper
      include Refinery::TagHelper


      attr_accessor :context, :collection
      delegate :output_buffer, :output_buffer=, to: :context

      config_accessor :group_tag, :list_classes
      self.group_tag = :ul
      self.list_classes = ['components', 'pagination_frame', 'frame_center']

      def initialize(collection, context)
        @collection = collection
        @context = context
      end

      def refinery
        Refinery::Core::Engine.routes.url_helpers
      end

      def to_html
        view_name = Refinery::Caststone::Components.preferred_view
        list_classes.push view_name
        tag.ul class: list_classes do
          render_components(collection, view_name)
        end
      end

      def render_components(components, view_name)
        header = get_header(view_name)
        markup = components.each.reduce(ActiveSupport::SafeBuffer.new) do |buffer, component|
          buffer << render_list_item(component) {
            view_name == "grid" ? grid_view(component).html_safe : list_view(component).html_safe
          }
        end
        header << markup
      end

      private

        def render_list_item(component)
          tag.li id: component.id, class: component.type.demodulize do
            yield (component)
          end
        end

        def header_element(attribute)
          tag.span attribute.capitalize, class: attribute
        end

        def entry(component, attribute)
          tag.span component.send(attribute), class: attribute
        end

        def list_of(component, attribute)
          tag.span component.send(attribute).map(&:name).join(', '), class: attribute
        end
        def get_header(view_name)
          return ''.html_safe if view_name == :grid

          tag.li class: 'header' do
            [header_element("kind"),
             header_element("name"),
             header_element("height"),
             header_element("series"),
             header_element("actions")].join(' ').html_safe
          end
        end

        def image(drawing)
          tag.img src: drawing.thumb({geometry: :index}).url, title: name, alt: name
        end


        def grid_view(component)
          image = component.drawing.presence || (tag.p "No Drawing")
          info = [entry(component, 'name'), entry(component, 'height'), list_of(component, 'products')].join(' ')
          image << info << actions(component)
        end

        def list_view(component)
          info = [entry(component, 'kind'),
                  entry(component, 'name'),
                  entry(component, 'height'),
                  list_of(component, 'products')].join(' ')
          info << actions(component)
        end
        def products_list(component)
          component.products.map(&:name).join(',')
        end
        def actions(component)
          edit = action_icon :edit, refinery.edit_caststone_admin_component_path(component), ::I18n.t('.edit')
          delete = action_icon :delete, refinery.caststone_admin_component_path(component), ::I18n.t('.delete'),
                               class: 'cancel confirm-delete',
                               data: {confirm: ::I18n.t('message', scope: 'refinery.admin.delete', title: component.name)}
          tag.div class: :actions do
            edit << delete
          end
        end
    end
  end
end
