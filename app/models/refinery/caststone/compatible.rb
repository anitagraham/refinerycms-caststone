module Refinery
  module Caststone
    class Compatible < Refinery::Core::BaseModel

      belongs_to  :product,    foreign_key: :product_id, class_name: "Refinery::Caststone::Product", inverse_of: :compatibles
      belongs_to  :component,  foreign_key: :component_id, class_name: "Refinery::Caststone::Component", inverse_of: :compatibles

      belongs_to :base,       foreign_key: :component_id, optional: true
      belongs_to :shaft,      foreign_key: :component_id, optional: true
      belongs_to :capital,    foreign_key: :component_id, optional: true
      belongs_to :column,     foreign_key: :component_id, optional: true
      belongs_to :letterbox,  foreign_key: :component_id, optional: true
      belongs_to :trim,       foreign_key: :component_id, optional: true
    end
  end
end
