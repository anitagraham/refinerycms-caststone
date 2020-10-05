module Refinery
  module ImageHelper

    def image_fu(image, geometry = nil, options = {})

      return nil if image.blank?

      photo_number = ''
      if image.photo_number.present?
        photo_number = tag.span image.photo_number, class: photo_number
      end

      thumbnail_args = options.slice(:strip)
      thumbnail_args[:geometry] = geometry if geometry
      image_tag_args = (image.thumbnail_dimensions(geometry) rescue {})
      image_tag_args[:alt] = image.respond_to?(:title) ? image.title : image.image_name

      image_tag(image.thumbnail(thumbnail_args).url, image_tag_args.merge(options)) << photo_number

    end

    # def photo_number(image)
    #   tid = [image.title, image.alt, image.image_name.split('.').first].find{ |name| name.match(photo_number)}
    #   tid.blank? ? tid : tag.span(tid, class: 'photo_number')
    # end
  end
end
