require 'dragonfly'

module Refinery
  module Caststone
    class Photo < Refinery::Core::BaseModel
      include Rails.application.routes.url_helpers
      include ActionView::Helpers::UrlHelper

      attr_accessor :height, :src, :copyright_image_url, :label

      scope :by_series, -> {order(:product_id)}

      default_scope { order(:name) }

      acts_as_indexed :fields => [:title, :caption]
      alias_attribute :title, :name

      validates :name, :presence => true, :uniqueness => true
      dragonfly_accessor :image, app: :caststone_photos

      belongs_to :product
      belongs_to :page, :inverse_of => :photos,  :foreign_key => 'page_id'

      has_many :assignments
      has_many :components,  :through => :assignments
      has_many :bases,       :through => :assignments, :foreign_key=>'component_id'
      has_many :shafts,      :through => :assignments, :foreign_key=>'component_id'
      has_many :capitals,    :through => :assignments, :foreign_key=>'component_id'
      has_many :columns,     :through => :assignments, :foreign_key=>'component_id'
      has_many :letterboxes, :through => :assignments, :foreign_key=>'component_id'

      before_destroy {|photo| photo.components.clear}
      before_update :save_drawing
      before_save   :save_drawing

      self.per_page = 30

      def as_json(options={})
        json = super(options)
        json['src_small'] = thumbnail(geometry: :small)
        json['src_large'] = thumbnail(options)
        json['imageurl'] = copyright_image_url
        json['label'] = caption || name
        json
      end

			def status(part)
				case part
					when 'components'
						components.count > 0 ? 'OK' : 'warning'
					when 'page'
						page.present? ? 'OK' : 'warning'
					when 'record'
						components.count >0 && page.present? ? 'OK' : 'warning'
					else
						'OK'
				end
			end

      def height
        self.components.sum(:height)
      end

      def with_geometry(size)
      	Rails.logger.debug "Getting Geometry #{size.to_s}"
        thumbnail({geometry: size})
      end

      def label
        caption || name
      end

      # Get a thumbnail job object given a geometry and whether to strip image profiles and comments.
      def thumbnail(options = {})
        options = { geometry: '600x400', :strip => false }.merge(options)
        geometry = convert_to_geometry(options[:geometry])
        thumbnail = image
        thumbnail = thumbnail.thumb(geometry) if geometry
        thumbnail = thumbnail.strip if options[:strip]
        thumbnail.url
      end

      # Intelligently works out dimensions for a thumbnail of this image based on the Dragonfly geometry string.
      def thumbnail_dimensions(geometry)
      	Rails.logger.debug "beginning thumbnail dimensions"
        dimensions = ThumbnailDimensions.new(geometry, image.width, image.height)
        Rails.logger.debug "Ended thumbnail dimensions"
        { :width => dimensions.width, :height => dimensions.height }

      end

     def convert_to_geometry(geometry)
        if geometry.is_a?(Symbol) && Refinery::Caststone::Photos.sizes.keys.include?(geometry)
          Refinery::Caststone::Photos.sizes[geometry]
        else
          geometry
        end
      end

      def copyright_image_url
        pointsize = 16
        image.convert("-gravity southeast -pointsize #{pointsize} -fill white -annotate 0 '(c) www.caststone.com.au #{Time.now.year}'").url
      end

      def popup_image
         name thumbnail('250x')
      end

      private

      def save_drawing
        #       always save the drawing - won't be changed that often.
        #       bonus: saves the height too.
        component_ids = self.base_ids + self.shaft_ids + self.column_ids + self.capital_ids + self.letterbox_ids
        self.drawing = component_ids.present? ? Refinery::Caststone::Component.construct(component_ids) : nil
        self.height = self.components.sum('height')
      end
    end
  end
end
