# frozen_string_literal: true

module Refinery
  module Caststone
    class Photo < Refinery::Core::BaseModel

      PERMITTED_CHARACTERS = '0-9A-Z -'.freeze
      self.table_name = 'refinery_caststone_photos'

      acts_as_indexed fields: %i[name photo_number]

      validates :name, presence: true, uniqueness: true
      validates :image, presence: true

      belongs_to :image, dependent: :destroy, touch: true
      belongs_to :product, inverse_of: :photos, optional: true, touch: true
      belongs_to :page, inverse_of: :photos, foreign_key: :page_id, optional: true, touch: true

      has_many :assignments
      has_many :components, through: :assignments
      # has_many :bases, -> { where(component.type = "Refinery::Caststone::Base" ) }
      # has_many :shafts, -> { where(component.type = "Refinery::Caststone::Shaft" ) }
      # has_many :capitals, -> { where(component.type = "Refinery::Caststone::Capital" ) }
      # has_many :columns, -> { where(component.type = "Refinery::Caststone::Column" ) }
      # has_many :letterboxes, -> { where(component.type = "Refinery::Caststone::Letterbox" ) }
      # has_many :trims, -> { where(component.type = "Refinery::Caststone::Trim" ) }
      has_many :bases, through: :assignments, foreign_key: 'component_id', class_name: 'Refinery::Caststone::Base'
      has_many :shafts, through: :assignments, foreign_key: 'component_id', class_name: 'Refinery::Caststone::Shaft'
      has_many :capitals, through: :assignments, foreign_key: 'component_id', class_name: 'Refinery::Caststone::Capital'
      has_many :columns, through: :assignments, foreign_key: 'component_id', class_name: 'Refinery::Caststone::Column'
      has_many :letterboxes, through: :assignments, foreign_key: 'component_id', class_name: 'Refinery::Caststone::Letterbox'
      has_many :trims, through: :assignments, foreign_key: 'component_id', class_name: 'Refinery::Caststone::Trim'

      before_destroy { |photo| photo.components.clear }

      warning do |photo|
        photo.warnings.add(:components, 'No components defined') unless photo.components.any?
        photo.warnings.add(:image, 'No image loaded') unless photo.image
        photo.warnings.add(:photo_number, 'No tracking id assigned') unless photo.photo_number
      end

      def complete?
        image.present? &&
        photo_number.present?
      end

      scope :image_present, ->  { where.not(image_id: nil) }
      scope :tracking_added, -> { where.not(photo_number: nil) }
      scope :components_added, -> {where('components_count>0')}
      scope :complete, -> { image_present.tracking_added }

      def view(options = {})
        default_options = {
          small_size: :small,
          large_size: ''
        }
        options = default_options.merge(options)
        # large image can be the original, full size image

        url_large = options[:large_size].blank? ? image.url : thumbnail(geometry: options[:large_size]).url
        {
          id: id,
          url_large: url_large,
          url_small: thumbnail(geometry: options[:small_size]).url,
          label: name
        }
      end


      def assigned_page_name
        page.present? ? page.title : 'unassigned'
      end

      def height
        components.sum(:height) if components.any?
      end

      def component_count
        components.any? ? components.count : 'None'
      end

      def popup_image
        name thumb('250x')
      end

      private
        def save_drawing
          if components.present?
            self.drawing = CaststoneHelper.(component_ids)
            self.height = components.sum('height')
          end
        end
    end
  end
end
