# frozen_string_literal: true

module Refinery
  module Caststone
    class SubMenu < Refinery::BasePresenter
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::TagHelper
      include ActiveSupport::Configurable

      attr_accessor :collection, :context, :current_slug, :output_buffer

      config_accessor :classes,
                      :group_tag,
                      :item_tag,
                      :title_tag

      self.classes = [:sub_menu]
      self.group_tag = :ul
      self.item_tag = :li
      self.title_tag = :h4

      def initialize(collection, menu_title, current_slug, context)
        @context = context
        @current_slug = current_slug
        @collection = collection
        @menu_title = menu_title
      end

      def item_to_html(item)
        if item.is_a? String
          tag.send title_tag, item
        else
          link_to_options = { id: item.id }
          link_to_options = link_to_options.merge({ class: 'active' }) if item.slug == @current_slug
          tag.send(item_tag) do
            link_to item.name, @context.refinery.url_for(action: :show, id: item.slug), link_to_options
          end
        end
      end

      def to_html
        title = tag.send title_tag, @menu_title
        submenu = tag.send group_tag do
          collection.each.reduce(ActiveSupport::SafeBuffer.new) do |buffer, item|
            buffer << item_to_html(item)
          end
        end
        title << submenu
      end
    end

  end # module
end # module
