module Refinery
  module Caststone
    class SubMenu < Refinery::BasePresenter
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::TagHelper
      include ActiveSupport::Configurable

      config_accessor :item_tag, :group_tag

      self.item_tag = :li
      self.group_tag = :ul

      attr_accessor :output_buffer

      def initialize(collection, current_object_id, context)
        @context = context
        @current_object_id = current_object_id
        @collection = collection.map{ |item|
          { id: item.id, slug: item.slug, title: item.name || item.title}
        }
      end

      def item_to_html(item)
        link_to_options = {id: item[:id]}
        if item[:slug] == @current_object_id
          link_to_options = link_to_options.merge({class: 'active'})
        end
        tag.send(item_tag) do
          link_to item[:title], @context.refinery.url_for(action: :show, id: item[:slug]), link_to_options
        end
      end

      def to_html
        tag.send(group_tag, class: 'menu') do
          @collection.each.reduce(ActiveSupport::SafeBuffer.new) do |buffer, item|
            buffer << item_to_html(item)
          end
        end
      end

    end  #class
  end #module
end #module
