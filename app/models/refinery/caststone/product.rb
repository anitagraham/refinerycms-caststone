module Refinery
  module Caststone
    class Product < Refinery::Core::BaseModel
      extend FriendlyId

      friendly_id :name, use: [:slugged]

      acts_as_indexed fields: [:name, :description]
      is_seo_meta

      # Gutentag::ActiveRecord.call self

      belongs_to :brochure,       class_name: 'Refinery::Resource', optional: true
      belongs_to :brochure_cover, class_name: 'Refinery::Image', optional: true
      belongs_to :drawing,        class_name: 'Refinery::Image', optional: true
      belongs_to :image,          class_name: 'Refinery::Image', optional: true

      validates :name, presence: true, uniqueness: true

      has_many :photos, -> {includes :components}, inverse_of: :product

      has_many :compatibles,  foreign_key: :product_id, inverse_of: :product
      has_many :components,   through: :compatibles, foreign_key: :component_id, inverse_of: :products,  dependent: :destroy

      has_many :bases,        through: :compatibles, foreign_key: :component_id, inverse_of: :products, dependent: :destroy, source: :base
      # Rails can't choose between base and basis
      has_many :shafts,       through: :compatibles, foreign_key: :component_id, inverse_of: :products, dependent: :destroy
      has_many :capitals,     through: :compatibles, foreign_key: :component_id, inverse_of: :products, dependent: :destroy
      has_many :columns,      through: :compatibles, foreign_key: :component_id, inverse_of: :products, dependent: :destroy
      has_many :letterboxes,  through: :compatibles, foreign_key: :component_id, inverse_of: :products, dependent: :destroy
      has_many :trims,        through: :compatibles, foreign_key: :component_id, inverse_of: :products, dependent: :destroy

      accepts_nested_attributes_for :bases,       reject_if: :blank_content, allow_destroy: true
      accepts_nested_attributes_for :letterboxes, reject_if: :blank_content, allow_destroy: true
      accepts_nested_attributes_for :capitals,    reject_if: :blank_content, allow_destroy: true
      accepts_nested_attributes_for :columns,     reject_if: :blank_content, allow_destroy: true
      accepts_nested_attributes_for :shafts,      reject_if: :blank_content, allow_destroy: true
      accepts_nested_attributes_for :trims,       reject_if: :blank_content, allow_destroy: true

      warning do |product|
        product.warnings.add(:components, ": No components defined") unless product.components.any?
        product.warnings.add(:image, ": No image loaded") unless product.image.present?
        product.warnings.add(:brochure, ": No Brochure loaded") unless product.brochure.present?
        [:description, :summary, :features, :measurements].each do |field|
          product.warnings.add(field, " not filled in") unless product.send(field).present?
        end
      end

      def to_s
        name
      end

      def all_text_fields_filled_in
        description.present? && summary.present? && features.present? && measurements.present?
      end

      def uses(component_type)
        Refinery::Caststone::Products::USES[product_type.downcase.to_sym]&.include? component_type.downcase.to_sym
      end

      def component_count
        components.count
      end

      def pillar?
        product_type.downcase == 'pillar'
      end

      def group_entry?
        slug.downcase == 'group'
      end
      
      scope :single_product, -> { where.not( slug:'group') }
      scope :pillars, -> { where( product_type:  'Pillar') }

      # borrowed from Refinery::Page
      class FriendlyIdOptions
        def self.options
          # Docs for friendly_id https://github.com/norman/friendly_id
          friendly_id_options = {
            use: [ :reserved],
            reserved_words: Refinery::Pages.friendly_id_reserved_words
          }
          friendly_id_options
        end
      end

      extend FriendlyId
      friendly_id :name, FriendlyIdOptions.options

      def should_generate_new_friendly_id?
        name_changed? || super
      end
    end
  end
end
