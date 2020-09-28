module Refinery
  module Caststone
    class Button
      require "ostruct"
      BUTTON_TYPES = [
        ostruct.new({title: 'Call To Action', type: :cta}),
        ostruct.new({title: 'Download', type: :download})
      ]
      attr_accessor :title, :type

      def initialize(title, type)
        @title = title
        @type = type
      end

      def style(style_name)
        @style = style_name
        self
      end
      def link(link_url)
        @link = link_url
        self
      end

      def to_html
        link_to @title, @link, class: [:button, @type, @style]
      end
    end
  end
end
