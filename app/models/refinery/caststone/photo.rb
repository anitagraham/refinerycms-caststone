# frozen_string_literal: true

module Refinery
  module Caststone
    class Photo < Refinery::Core::BaseModel

      self.table_name = 'refinery_caststone_photos'

      scope :by_series, -> { order(:product_id) }
      acts_as_indexed fields: %i[title caption]

      validates :name, presence: true, uniqueness: true
      # belongs_to :image, class: Refinery::Image
      dragonfly_accessor :image, app: :caststone_photos

      belongs_to :product
      belongs_to :page, inverse_of: :photos, foreign_key: :page_id

      has_many :assignments
      has_many :components, through: :assignments
      has_many :bases, through: :assignments, foreign_key: 'component_id'
      has_many :shafts, through: :assignments, foreign_key: 'component_id'
      has_many :capitals, through: :assignments, foreign_key: 'component_id'
      has_many :columns, through: :assignments, foreign_key: 'component_id'
      has_many :letterboxes, through: :assignments, foreign_key: 'component_id'

      before_destroy { |photo| photo.components.clear }
      before_update :save_drawing
      before_save :save_drawing

      def slide_show_view(size)
        {
          url_large: thumb(geometry: size.to_sym).url,
          thumbnail_url: thumb(geometry: :small).url,
          label: caption || name
        }
      end

      def as_json( options = {})
        super(options).merge({
           label: caption || name,
           image_full: image.url,
           image_large: image.thumb(Refinery::Caststone::Photos.sizes[:large]).url,
           image_small: image.thumb(Refinery::Caststone::Photos.sizes[:small]).url
         })
      end
      # def as_json(context)
      #   {id: id,
      #    srcset_full: image.url,
      #    srcset_large: thumbnail(geometry: :large).url,
      #    srcset_small: thumbnail(geometry: :small).url,
      #    thumbnail_url: thumbnail(geometry: context).url,
      #    label: caption || name
      #   }
      # end

      # def status(part)
      #   case part
      #     when 'components'
      #       components.count.positive? ? 'OK' : 'warning'
      #     when 'page'
      #       page.present? ? 'OK' : 'warning'
      #     when 'record'
      #       components.count.positive? && page.present? ? 'OK' : 'warning'
      #     else
      #       'OK'
      #   end
      # end

      def assigned_page_name
        page.present? ? page.title : 'unassigned'
      end

      def height
        components.sum(:height)
      end

      def popup_image
        name thumb('250x')
      end

      private

        def save_drawing
          #       always save the drawing - won't be changed that often.
          #       bonus: saves the height too.
          component_ids = base_ids + shaft_ids + column_ids + capital_ids + letterbox_ids
          self.drawing = component_ids.present? ? Refinery::Caststone::Component.construct(component_ids) : nil
          self.height = components.sum('height')
        end
    end
  end
end
