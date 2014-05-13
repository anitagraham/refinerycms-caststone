module Refinery
  module Caststone
    module Admin
      class ProductsController < ::Refinery::AdminController
      	
				before_filter :list_components
        crudify :'refinery/caststone/product',
                :title_attribute => 'name', :xhr_paging => true
			
				def show
					@series = Refinery::Caststone::Product.find(params[:id], :include => :components)
				end
				protected

				def list_components
					@components = Refinery::Caststone::Component.order(:name)
				end
      end
    end
  end
end
