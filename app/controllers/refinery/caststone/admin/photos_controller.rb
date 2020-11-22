module Refinery
  module Caststone
    module Admin
      class PhotosController < ::Refinery::AdminController
        helper CaststoneHelper

        respond_to :html, :js
        respond_to :json
        respond_to :png, only: :draw

        before_action :set_view, only: :index
        before_action :find_all_series, only: [:edit, :new]

        crudify :'refinery/caststone/photo',
                title_attribute: 'name', paging: true,
                class_name: 'Refinery::Caststone::Photo',
                singular_name: 'photo',
                plural_name: 'photos'

        # Finds one single result based on the id params.
        def find_photo
          @photo = Refinery::Caststone::Photo.includes(product: :components).find(params[:id])
          @components = @photo.product.components if @photo.product
        end

        def draw
          send_data CaststoneHelper.drawing(params[:component_ids]), type: 'image/png', disposition: 'inline'
        end

        protected

        def find_all_series
          @products = Refinery::Caststone::Product.where.not( slug:'group')
        end

        def set_view
          if action_name == 'index' && params[:view].present? && Refinery::Caststone::Photos.defined_views.include?(params[:view].to_sym)
            Refinery::Caststone::Photos.preferred_view = params[:view]
          end
        end

        def photo_params
          params.require(:photo).permit(
            :name, :caption, :page, :position, :drawing, :image, :image_id, :page_id, :product_id, :photo_number,
            base_ids: [],  capital_ids: [], column_ids: [], component_ids: [], letterbox_ids: [], shaft_ids: [],  trim_ids:[])
        end
      end
    end
  end
end
