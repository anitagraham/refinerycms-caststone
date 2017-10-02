module Refinery
  module Caststone
    class Template < Refinery::Core::BaseModel

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true

      has_many :fields


      def to_s
        name
      end

    end
  end
end
