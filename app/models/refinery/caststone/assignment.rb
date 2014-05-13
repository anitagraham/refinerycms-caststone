module Refinery
  module Caststone
    class Assignment < Refinery::Core::BaseModel
      belongs_to :photo
      belongs_to :component 
      belongs_to :base, :foreign_key=>'component_id'     
      belongs_to :shaft, :foreign_key=>'component_id'     
      belongs_to :capital, :foreign_key=>'component_id'     
      belongs_to :column, :foreign_key=>'component_id'     
      belongs_to :letterbox, :foreign_key=>'component_id'     
    end
  end
end 