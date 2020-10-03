# frozen_string_literal: true

module Refinery
  module Caststone
    class SubMenu < Refinery::BasePresenter
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::TagHelper
      include ActiveSupport::Configurable

      config_accessor :classes,
                      :group_header_tag,
                      :group_tag,
                      :item_tag,
                      :others_title,
                      :pillars_title,
                      :title,
                      :title_tag

      self.classes = [:sub_menu]
      self.group_header_tag = :h3
      self.group_tag = :ul
      self.item_tag = :li
      self.others_title = ''
      self.pillars_title = ''
      self.title = ''
      self.title_tag = :h2

      attr_accessor :output_buffer

      def initialize(collection, current_slug, context)
        @context = context
        @current_slug = current_slug
        collection = collection.map do |item|
          {id: item.id, slug: item.slug, title: item.name || item.title, type: item.product_type.downcase}
        end
        @pillars, @others = collection.partition { |item| item[:type] == 'pillar' }
      end

      def item_to_html(item)
        link_to_options = {id: item[:id]}
        link_to_options = link_to_options.merge({class: 'active'}) if item[:slug] == @current_slug
        tag.send(item_tag) do
          link_to item[:title], @context.refinery.url_for(action: :show, id: item[:slug]), link_to_options
        end
      end

      def to_html
        submenu_title = tag.send(title_tag, title, class: :submenu_title)
        submenu = tag.send(group_tag, class: classes) do
          [
           group_with_header(@pillars, pillars_title),
           group_with_header(@others, others_title)
          ].join(' ').html_safe
        end
        submenu_title << submenu
      end

      def group_with_header(group, header = '')
        header = tag.send(group_header_tag, header, class: 'sub_menu_header') if header.present?
        list = group.each.reduce(ActiveSupport::SafeBuffer.new) do |buffer, item|
          buffer << item_to_html(item)
        end
        header << list
      end

    end

    # class
  end # module
end # module
