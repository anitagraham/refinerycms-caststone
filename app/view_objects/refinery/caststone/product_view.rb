module Refinery
  module Caststone
    class ProductView
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::AssetTagHelper
      include ActiveSupport::Configurable
      include Refinery::ImageHelper

      attr_accessor :title, :subtitle, :slug, :output_buffer

      def initialize(product, context)
        @markup = []
        @product_url = context.refinery.caststone_product_path(product)
        @product = product
        @slug = product.slug
        @context = context
      end

      def banner(full_width = true)
        banner_classes = [:banner, :centre]
        if full_width
          banner_classes << :fullwidth
        end

        title = tag.span @product.name, class: :product_name
        subtitle = tag.span @product.tag_line, class: :tag_line
        tag.section class: [banner_classes] do
          title << subtitle
        end
      end

      def related_pages(title, items)
        title_tag = tag.h3 title, class: :secondary_nav_title
        title_tag << items.to_html
      end

      def product_page_link
        header = tag.h4 @title
        tag_line = tag.p @subtitle
        tag.li class: 'product_link' do
          link_to @product_page do
            header << tag_line << image_fu(product.drawing, Refinery::Images.user_image_sizes[:small])
          end
        end
      end

      def formatted_field(name)
        tag.div id: name, class: :text_field do
          @product.send(name).html_safe
        end
      end

      def slide_data
        valid_photos = @product.photos.filter(&:complete?)
        valid_photos.map { |photo|
          PhotoView.new(photo)
            .drawing
            .wrap_content_tag(:figure)
            .tracking
            .copyright
            .carousel
            .components
            .sizes([{geometry: :largeSlide, width: '1200w'},
                    {geometry: :smallSlide, width: '600w'}])
            .markup
        }
      end

      def brochure
        cover_image = image_fu(@product.brochure_cover, :brochureCover)
        data_set = {icons: 'download'}
        classes =  [:download, :brochure, :button]
        button  = link_to  'Download PDF', @product.brochure.url, class: classes, data: data_set
        tag.figure cover_image << button
      end
    end
  end
end
