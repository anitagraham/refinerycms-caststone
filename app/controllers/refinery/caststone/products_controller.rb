module Refinery
  module Caststone
    class ProductsController < ::ApplicationController
      respond_to :json, :html

      def components
        respond_to :json
        series = Refinery::Caststone::Product.friendly.find(params[:id])
        @components = series.components
      end

      def index
        @products = Refinery::Caststone::Product.all
      end

      def show
        @product = Refinery::Caststone::Product.friendly.find(params[:id])
      end

      def list
        series = Refinery::Caststone::Product.friendly.find(params[:id])
        comp_type = params[:type]
        @components = series.send(comp_type)
      end
    end
  end
end

