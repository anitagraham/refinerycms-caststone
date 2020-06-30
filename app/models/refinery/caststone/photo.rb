# frozen_string_literal: true

module Refinery
  module Caststone
    class Photo < Refinery::Core::BaseModel

      PERMITTED_CHARACTERS = "0-9A-Z -".freeze
      self.table_name = 'refinery_caststone_photos'

      acts_as_indexed fields: %i[name trackid]

      validates :name, presence: true, uniqueness: true
      # dragonfly_accessor :image, app: :caststone_photos

      belongs_to :product
      belongs_to :image
      belongs_to :page, inverse_of: :photos, foreign_key: :page_id, optional: true

      has_many :assignments
      has_many :components,   through: :assignments
      # has_many :bases, -> { where(component.type = "Refinery::Caststone::Base" ) }
      # has_many :shafts, -> { where(component.type = "Refinery::Caststone::Shaft" ) }
      # has_many :capitals, -> { where(component.type = "Refinery::Caststone::Capital" ) }
      # has_many :columns, -> { where(component.type = "Refinery::Caststone::Column" ) }
      # has_many :letterboxes, -> { where(component.type = "Refinery::Caststone::Letterbox" ) }
      # has_many :trims, -> { where(component.type = "Refinery::Caststone::Trim" ) }
      has_many :bases,        through: :assignments, foreign_key: 'component_id', foreign_type: 'Refinery::Caststone::Base'
      has_many :shafts,       through: :assignments, foreign_key: 'component_id'
      has_many :capitals,     through: :assignments, foreign_key: 'component_id'
      has_many :columns,      through: :assignments, foreign_key: 'component_id'
      has_many :letterboxes,  through: :assignments, foreign_key: 'component_id'

      before_destroy { |photo| photo.components.clear }
      before_update :save_drawing, :set_track_id
      before_save :save_drawing, :sanitize_name, :set_track_id

      def sanitize_name
        name.gsub(/.jpg$/i, '')
        name.gsub(/.png$/i, '')
        name.gsub(/\(\d{1,3}\)/, '')
        name.gsub(/[^0-9A-Z -]/i, '_')
      end

      def set_track_id
        end_token = name.split.last.to_i
        start_token = name.split.first.to_i
        trackid = end_token || start_token
      end

      def view(options={})
        default_options = {
          small_size: :small,
          large_size: ''
        }
        options = default_options.merge(options)
        # large image can be the original, full size image

        url_large = options[:large_size].blank? ? image.url : thumbnail(geometry: options[:large_size] ).url
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
          # component_ids = base_ids + shaft_ids + column_ids + capital_ids + letterbox_ids
          if components.present?
            self.drawing = Refinery::Caststone::Component.construct(component_ids)
            self.height = components.sum('height')
          end
        end
    end
  end
end
