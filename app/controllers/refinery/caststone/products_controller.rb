module Refinery
  module Caststone
    class ProductsController < ::ApplicationController
      respond_to :json, :js, :html

      def components
        @series = Refinery::Caststone::Product.friendly.find(params[:id])
        render 'refinery/caststone/admin/products/components', @series
      end

      def index
        @products = Refinery::Caststone::Product.order(:position)
      end

      def show
        @product = Refinery::Caststone::Product.friendly.find(params[:id])
        # use for submenu
        @products = Refinery::Caststone::Product.order(:position)
      end

      def list
        series = Refinery::Caststone::Product.friendly.find(params[:id])
        comp_type = params[:type]
        @components = series.send(comp_type)
      end
    end
  end
end

