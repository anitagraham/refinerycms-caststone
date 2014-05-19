module Refinery
  module Caststone
    module Photos
      module Extension
        def has_many_photos
          has_many :photos,  :class_name=>"Refinery::Caststone::Photo"
          # has_many :photos, :class_name => 'Refinery::Caststone::Photo', :inverse_of => :page, :foreign_key => 'page_id'
          attr_accessible :photo_ids
        end
      end
    end
  end
end

ActiveRecord::Base.send(:extend, Refinery::Caststone::Photos::Extension)