module Refinery
  module Caststone
    class Product < Refinery::Core::BaseModel

      acts_as_indexed :fields => [:name]
      has_one :drawing, class_name: 'Refinery::Image'
      validates :name, :presence => true, :uniqueness => true

      has_many :compatibles
      has_many :components, :through => :compatibles, :dependent => :destroy
      has_many :bases,      :through => :compatibles, :foreign_key => :component_id, :dependent => :destroy
      has_many :shafts,     :through => :compatibles, :foreign_key => :component_id, :dependent => :destroy
      has_many :capitals,   :through => :compatibles, :foreign_key => :component_id, :dependent => :destroy
      has_many :columns,    :through => :compatibles, :foreign_key => :component_id, :dependent => :destroy
      has_many :letterboxes,:through => :compatibles, :foreign_key => :component_id, :dependent => :destroy


      accepts_nested_attributes_for :bases,       :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
      accepts_nested_attributes_for :letterboxes, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
      accepts_nested_attributes_for :capitals,    :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
      accepts_nested_attributes_for :columns,     :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
      accepts_nested_attributes_for :shafts,      :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

      def to_s
        name
      end

    end
  end
end
