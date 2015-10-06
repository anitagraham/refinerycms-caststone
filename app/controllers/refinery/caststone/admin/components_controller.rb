module Refinery
	module Caststone
		module Admin
			class ComponentsController < ::Refinery::AdminController
				respond_to :png, :only => :draw
				respond_to :html, :js

				crudify :'refinery/caststone/component',
                :title_attribute => 'name',
                :order => 'name ASC'

				def list_for_series
					Refinery::Caststone::Component.filter_by_series(params[:id])
				end

				def draw
					send_data  Refinery::Caststone::Component.construct(params[:list]), :type => 'image/png', :disposition => 'inline'
				end

        protected
        def component_params
          params.require(:component).permit(:type, :name, :note, :height, :drawing, :drawing_uid, series_ids: [])
        end
			end
		end
	end
end
