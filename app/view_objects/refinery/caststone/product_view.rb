module Refinery
  module Caststone
    class ProductView
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::AssetTagHelper
      include ActiveSupport::Configurable
      include Refinery::ImageHelper

      attr_accessor  :context, :id, :product, :output_buffer
      delegate_missing_to :product

      def initialize(product, context)
        @markup = []
        @product = product
        @context = context
      end


      def banner(full_width = true)
        banner_classes = [:banner, :centre]
        banner_classes.push :full_width if full_width
        tag.section class: [banner_classes] do
          tag.span(product.name, class: :product_name) << tag.span(product.tag_line, class: :tag_line)
        end
      end


      def show_url
        context.refinery.caststone_product_path(product)
      end

      def show_link
        header = tag.h4 product.name, class: :product_name
        tag_line = tag.p product.tag_line
        tag.li class: 'product_link' do
          link_to show_url do
            header << tag_line << image_fu( product.drawing, Refinery::Images.user_image_sizes[:small])
          end
        end
      end

      def formatted_field(name)
        tag.section id: name, class: :text_field do
          product.send(name).html_safe
        end
      end

      # def slide_data
      #   valid_photos = product.photos.filter(&:complete?)
      #   valid_photos.map { |photo|
      #     PhotoView.new(photo)
      #       .drawing
      #       .blur
      #       .wrap_content_tag(:figure)
      #       .tracking
      #       .copyright
      #       .carousel
      #       .components
      #       .sizes([{geometry: :largeSlide, width: 1200},
      #               {geometry: :smallSlide, width: 600}])
      #       .markup
      #   }
      # end

      def download_cta
        words1 = "FREE \n CastStone\n #{product.short_name} Planner"
        words2 = "Download NOW"

      end
      def brochure
        classes = [ :brochure, :button]
        icon = tag.i class: ['fas', 'fa-download']
        text = ['Download your <span>FREE</span> Customisation Planner', '<br />', icon].join(' ').html_safe
        tag.div do
          tag.a(text, href: product.brochure.url, class: classes)
        end
      end
    end
  end
end
