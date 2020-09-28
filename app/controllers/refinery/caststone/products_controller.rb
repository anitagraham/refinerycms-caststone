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
        product = Refinery::Caststone::Product.friendly.find(params[:id])
        @product = Refinery::Caststone::ProductView.new(product, view_context)
        if product.pillar?
          all_pillars = Refinery::Caststone::Product.pillars.reject(&:group_entry?)
          @related_pages = Refinery::Caststone::SubMenu.new(all_pillars, params[:id], view_context)
        end
      end

      def list
        series = Refinery::Caststone::Product.friendly.find(params[:id])
        comp_type = params[:type]
        @components = series.send(comp_type)
      end
    end
  end
end

