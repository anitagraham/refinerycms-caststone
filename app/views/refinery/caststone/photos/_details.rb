module Refinery
  module Caststone
    module Photos
      class Details < ::Stache::Mustache::View
        def photo
          {photo: @photo.as_json}
        end
      end
    end
  end
end
