module Refinery
  module Caststone
    class ProductsController < ::ApplicationController
      respond_to :json

      def components
        respond_to :json
        series = Refinery::Caststone::Product.find_by_slug(params[:id])
        @components = series.components
        
      end

      def list
        series = Refinery::Caststone::Product.find(params[:id])
        comp_type = params[:type]
        @components = series.send(comp_type)
      end
    end
  end
end
