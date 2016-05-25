module Refinery
  module Caststone
    module Photos
      class Details < ::Stache::Mustache::View
        def photo
          {photo: @photo.as_json(include: :components)}
        end
      end
    end
  end
end
