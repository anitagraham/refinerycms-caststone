module Refinery
  module Caststone
    module Admin
      class ComponentsController < ::Refinery::AdminController
        helper CaststoneHelper

        # respond_to :png, only: :draw
        respond_to :html, :js

        before_action :set_view

        crudify :'refinery/caststone/component',
                title_attribute: 'name',
                order: 'type ASC, name ASC'

        protected

        def set_view
          if action_name == 'index' && params[:view].present? && Refinery::Caststone::Components.defined_views.include?(params[:view].to_sym)
            Refinery::Caststone::Components.preferred_view = params[:view]
          end
        end

        def component_params
          params.require(:component).permit(:type, :name, :note, :height, :drawing, :drawing_uid, :position, product_ids: [])
        end
      end
    end
  end
end
