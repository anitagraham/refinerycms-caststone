module Refinery
	module Caststone
		module Admin

			module PhotosHelper
				def other_photo_views
					Refinery::Caststone::Photos.photo_views.reject do |photo_view|
						photo_view.to_s == Refinery::Caststone::Photos.preferred_photo_view.to_s
					end
				end
			end

		end
	end
end

