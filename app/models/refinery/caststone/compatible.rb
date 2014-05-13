module Refinery
  module Caststone
    class Compatible < Refinery::Core::BaseModel
      belongs_to :product
      belongs_to :component 
      belongs_to :base,       :foreign_key=>'component_id'     
      belongs_to :shaft,      :foreign_key=>'component_id'     
      belongs_to :capital,    :foreign_key=>'component_id'     
      belongs_to :column,     :foreign_key=>'component_id'     
      belongs_to :letterbox,  :foreign_key=>'component_id'     
    end
  end
end 