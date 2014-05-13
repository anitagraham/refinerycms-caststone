module Refinery
  module Caststone
    class Capital < Refinery::Caststone::Component
            
      has_many :compatibles, :foreign_key => :component_id
      has_many :products, :through => :compatibles, :inverse_of => :capitals
          
    end
  end
end
