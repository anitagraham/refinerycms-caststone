module Refinery
  module Caststone
    class Compatible < Refinery::Core::BaseModel

      belongs_to  :product,    foreign_key: :product_id,   class_name: "Refinery::Caststone::Product",  inverse_of: :compatibles, optional: true
      belongs_to  :component,  foreign_key: :component_id, class_name: "Refinery::Caststone::Component",inverse_of: :compatibles, optional: true

      belongs_to :base,       foreign_key: :component_id, class_name: "Refinery::Caststone::Base",      inverse_of: :compatibles, optional: true
      belongs_to :shaft,      foreign_key: :component_id, class_name: "Refinery::Caststone::Shaft",     inverse_of: :compatibles, optional: true
      belongs_to :capital,    foreign_key: :component_id, class_name: "Refinery::Caststone::Capital",   inverse_of: :compatibles, optional: true
      belongs_to :column,     foreign_key: :component_id, class_name: "Refinery::Caststone::Column",    inverse_of: :compatibles, optional: true
      belongs_to :letterbox,  foreign_key: :component_id, class_name: "Refinery::Caststone::Letterbox", inverse_of: :compatibles, optional: true
      belongs_to :trim,       foreign_key: :component_id, class_name: "Refinery::Caststone::Trim",      inverse_of: :compatibles, optional: true
    end
  end
end
