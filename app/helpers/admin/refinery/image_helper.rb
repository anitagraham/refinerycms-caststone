module Refinery
  module ImageHelper
    TRACKING_ID = /\d{4}$/
    def image_fu(image, geometry = nil, options = {})

      return nil if image.blank?

      thumbnail_args = options.slice(:strip)
      thumbnail_args[:geometry] = geometry if geometry
      image_tag_args = (image.thumbnail_dimensions(geometry) rescue {})
      image_tag_args[:alt] = image.respond_to?(:title) ? image.title : image.image_name

      image_tag(image.thumbnail(thumbnail_args).url, image_tag_args.merge(options)) << tag.span(image.tracking_id.presence, class: 'tracking_id')

    end

    # def tracking_id(image)
    #   tid = [image.title, image.alt, image.image_name.split('.').first].find{ |name| name.match(TRACKING_ID)}
    #   tid.blank? ? tid : tag.span(tid, class: 'tracking_id')
    # end
  end
end
