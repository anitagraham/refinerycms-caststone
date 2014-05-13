module Refinery
  module Caststone
      class ProductsController < ::ApplicationController
       respond_to :json, :only=>:list
    
      def list                 
        series  = Refinery::Caststone::Product.find(params[:id])
        comp_type = params[:type]
        @components = series.send(comp_type)
      end      
    end
  end
end