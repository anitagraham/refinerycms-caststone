module Refinery
  module Caststone
    class Trim < Refinery::Caststone::Component

      has_many :compatibles, foreign_key: :component_id
      has_many :products, through: :compatibles, inverse_of: :trims

    end
  end
end
