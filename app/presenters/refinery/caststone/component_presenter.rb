module Refinery
  module Caststone
    class ComponentPresenter < Refinery::BasePresenter
      include ActiveSupport::Configurable
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::AssetTagHelper
      include ActionView::Helpers::TranslationHelper
      include Refinery::TagHelper

      GRID_VIEW_NAME = 'grid_view'
      attr_accessor :context, :collection, :grid
      delegate :output_buffer, :output_buffer=, to: :context

      config_accessor :group_tag, :list_classes
      self.group_tag = :ul
      self.list_classes = %w[components pagination_frame frame_center]

      def initialize(collection, context)
        @collection = collection
        @context = context
      end

      def refinery
        Refinery::Core::Engine.routes.url_helpers
      end

      def to_html
        view_name = "#{Refinery::Caststone::Components.preferred_view}_view"
        self.grid = view_name === GRID_VIEW_NAME
        self.list_classes |= [view_name]
        tag.ul class: self.list_classes do
          render_components(collection, view_name).html_safe
        end
      end

      def render_components(components, view_name)
        header = grid ? '' : get_header(view_name)
        markup = components.each.reduce(ActiveSupport::SafeBuffer.new) do |buffer, component|
          buffer << render_list_item(component) {
            grid ? grid_view(component).html_safe : list_view(component).html_safe
          }
        end
        [header, markup].join(' ').html_safe
      end

      private

        def render_list_item(component)
          tag.li id: component.id, class: component.type.demodulize.downcase do
            yield component
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

          tag.li class: 'header' do
            [header_element("kind"),
             header_element("name"),
             header_element("height"),
             header_element("series"),
             header_element("actions")].join(' ').html_safe
          end
        end

        def image(drawing)
          tag.img( src: drawing.thumb({geometry: :index}).url, title: drawing.name, alt: drawing.name )

        end


        def grid_view(component)

          if component.drawing.present?
            image(component.drawing)
          else
            Rails.logger.info "No drawing for component #{name}"
            image = tag.p "No Drawing available"
          end
          info = [entry(component, 'kind'),
                  entry(component, 'name'),
                  entry(component, 'height'),
                  list_of(component, 'products')].join(' ').html_safe
          [image, info,  actions(component)].join(' ').html_safe
        end

        def list_view(component)
          info = [entry(component, 'kind'),
                  entry(component, 'name'),
                  entry(component, 'height'),
                  list_of(component, 'products')].join(' ')
          [info,  actions(component)].join(' ')
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
