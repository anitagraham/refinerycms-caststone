require "sql_spy"
require "amazing_print"
module Refinery
  module Caststone
    class ProductsController < ::ApplicationController
      respond_to :json, :js, :html

      def index
        products = Refinery::Caststone::Product.order(:position).includes(:image, :drawing)
        @products = products.map { |product|
          Refinery::Caststone::ProductView.new(product, view_context)
        }
      end

      def show
        product = Refinery::Caststone::Product.where(slug: params[:id]).includes(:photos).first
        @product = Refinery::Caststone::ProductView.new(product, view_context)
        @related_pages = Refinery::Caststone::Product.where.not(slug: :group)
      end

      def list
        series = Refinery::Caststone::Product.friendly.find(params[:id])
        comp_type = params[:type]
        @components = series.send(comp_type)
      end
    end
  end
end

