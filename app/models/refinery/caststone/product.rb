module Refinery
  module Caststone
    class Product < Refinery::Core::BaseModel

      acts_as_indexed fields: [:name]
      has_one :drawing, class_name: 'Refinery::Image'
      validates :name, presence: true, uniqueness: true

      has_many :compatibles
      has_many :components,  through: :compatibles, dependent: :destroy
      has_many :bases,       through: :compatibles, foreign_key: :component_id, dependent: :destroy, source: :base  # Rails can't choose between base and basis
      has_many :shafts,      through: :compatibles, foreign_key: :component_id, dependent: :destroy
      has_many :capitals,    through: :compatibles, foreign_key: :component_id, dependent: :destroy
      has_many :columns,     through: :compatibles, foreign_key: :component_id, dependent: :destroy
      has_many :letterboxes, through: :compatibles, foreign_key: :component_id, dependent: :destroy
      has_many :trims,       through: :compatibles, foreign_key: :component_id, dependent: :destroy

      accepts_nested_attributes_for :bases,       reject_if:  :blank_content, allow_destroy: true
      accepts_nested_attributes_for :letterboxes, reject_if:  :blank_content, allow_destroy: true
      accepts_nested_attributes_for :capitals,    reject_if:  :blank_content, allow_destroy: true
      accepts_nested_attributes_for :columns,     reject_if:  :blank_content, allow_destroy: true
      accepts_nested_attributes_for :shafts,      reject_if:  :blank_content, allow_destroy: true
      accepts_nested_attributes_for :trims,       reject_if:  :blank_content, allow_destroy: true

      blank_content = -> attributes {attributes[:content].blank?}

      def to_s
        name
      end

      def component_count
        components.count
      end

      def is_a_pillar?
        self.product_type.present? & self.product_type.downcase == 'pillar'
      end

    end
  end
end
