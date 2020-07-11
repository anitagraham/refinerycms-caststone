module Refinery
  module Caststone
    class Product < Refinery::Core::BaseModel

      acts_as_indexed fields: [:name]
      # Gutentag::ActiveRecord.call self

      belongs_to :drawing, class_name: 'Refinery::Image', optional: true
      validates :name, presence: true, uniqueness: true

      has_many :compatibles,  foreign_key: :product_id
      has_many :components,   through: :compatibles,  inverse_of: :products, foreign_key: :component_id,  dependent: :destroy

      has_many :bases,        through: :compatibles, foreign_key: :component_id, dependent: :destroy, source: :base
      # Rails can't choose between base and basis
      has_many :shafts,       through: :compatibles, foreign_key: :component_id, dependent: :destroy, inverse_of: :products
      has_many :capitals,     through: :compatibles, foreign_key: :component_id, dependent: :destroy
      has_many :columns,      through: :compatibles, foreign_key: :component_id, dependent: :destroy
      has_many :letterboxes,  through: :compatibles, foreign_key: :component_id, dependent: :destroy
      has_many :trims,        through: :compatibles, foreign_key: :component_id, dependent: :destroy

      accepts_nested_attributes_for :bases,       reject_if: :blank_content, allow_destroy: true
      accepts_nested_attributes_for :letterboxes, reject_if: :blank_content, allow_destroy: true
      accepts_nested_attributes_for :capitals,    reject_if: :blank_content, allow_destroy: true
      accepts_nested_attributes_for :columns,     reject_if: :blank_content, allow_destroy: true
      accepts_nested_attributes_for :shafts,      reject_if: :blank_content, allow_destroy: true
      accepts_nested_attributes_for :trims,       reject_if: :blank_content, allow_destroy: true

      scope :pillars, -> { where(product_type: 'pillars') }
      # def pillars
      #   product_type == 'pillars'
      # end
      def to_s
        name
      end

      def component_count
        components.count
      end

      def is_a_pillar?
        self.product_type.present? & self.product_type == 'pillar'
      end

      # borrowed from Refinery::Page
      class FriendlyIdOptions
        def self.options
          # Docs for friendly_id https://github.com/norman/friendly_id
          friendly_id_options = {
            use: [ :reserved],
            reserved_words: Refinery::Pages.friendly_id_reserved_words
          }
          # if ::Refinery::Pages.scope_slug_by_parent
          #   friendly_id_options[:use] << :scoped
          #   friendly_id_options.merge!(scope: :parent)
          # end
          friendly_id_options
        end
      end

      extend FriendlyId
      friendly_id :name, FriendlyIdOptions.options

    end
  end
end
