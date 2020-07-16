module Refinery
  module Caststone
    class Assignment < Refinery::Core::BaseModel
      self.table_name = 'refinery_caststone_assignments'

      belongs_to :photo, class_name: 'Refinery::Caststone::Photo'
      belongs_to :component, class_name: 'Refinery::Caststone::Component'
      belongs_to :base, foreign_key: :component_id, class_name: 'Refinery::Caststone::Base', optional: true
      belongs_to :shaft, foreign_key: :component_id, class_name: 'Refinery::Caststone::Shaft', optional: true
      belongs_to :capital, foreign_key: :component_id, class_name: 'Refinery::Caststone::Capital', optional: true
      belongs_to :column, foreign_key: :component_id, class_name: 'Refinery::Caststone::Column', optional: true
      belongs_to :letterbox, foreign_key: :component_id, class_name: 'Refinery::Caststone::Letterbox', optional: true
    end
  end
end
