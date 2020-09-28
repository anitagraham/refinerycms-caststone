module Refinery
  module Caststone
    module Admin
      class ProductsController < ::Refinery::AdminController
        respond_to :html, :json

        crudify :'refinery/caststone/product',
                title_attribute: 'name',
                include: [:components]

        def show
          @series = Refinery::Caststone::Product.find(params[:id], include: :components)
        end

        def list_components
          Rails.logger.debug "Finding components for Series #{params[:id]}"
          series = Refinery::Caststone::Product.where(id: params[:id]).includes(:components).first
          @components = {
            bases: series.bases,
            shafts: series.capitals,
            capitals: series.capitals,
            letterboxes: series.letterboxes,
            trim: series.trims
          }
          respond_to :html, :js
        end

        def product_params
          params.require(:product).permit(
            :name, :tag_line, :description, :summary, :features, :measurements, :product_type,
            :brochure_id, :brochure_cover_id, :image_id, :drawing_id,
            :browser_title, :meta_description, :position, component_ids: [], photo_ids: []
          )
        end
      end
    end
  end
end
