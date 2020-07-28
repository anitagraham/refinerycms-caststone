module Refinery
  module Caststone
    module Admin
      class ProductsController < ::Refinery::AdminController

        #before_action :list_components
        crudify :'refinery/caststone/product',
                title_attribute: 'name'

        def show
          @series = Refinery::Caststone::Product.find(params[:id], include: :components)
        end

        def list_components
          @components = Refinery::Caststone::Component.order(:name)
          respond_to :html, :json
        end

        def product_params
          params.require(:product).permit(:name, :description, :position, :drawing_id, :trait_list, :product_type, component_ids:[])
        end
      end
    end
  end
end
