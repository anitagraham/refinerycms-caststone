module Refinery
  module Caststone
    class ProductsController < ::ApplicationController
      respond_to :json, :js, :html

      before_action :find_page

      def index
        products = Refinery::Caststone::Product.order(:position).includes(:image, :drawing)
        @products = products.map { |product|
          Refinery::Caststone::ProductView.new(product, view_context)
        }
        present(@product)
      end

      def show
        @related_pages = Refinery::Caststone::Product.where.not(slug: :group).order(:position)
        @product = Refinery::Caststone::Product.where(slug: params[:id]).includes(:photos).first
        fresh_when(@product)
        @product = Refinery::Caststone::ProductView.new(@product, view_context)
      end

      def list
        series = Refinery::Caststone::Product.friendly.find(params[:id])
        comp_type = params[:type]
        @components = series.send(comp_type)
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: "<%= index_route %>").first
      end
    end
  end
end

