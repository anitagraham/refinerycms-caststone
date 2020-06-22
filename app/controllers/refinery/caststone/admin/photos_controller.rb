#require "#{Rails.root}/vendor/extensions/caststone/app/models/refinery/caststone/photo.rb"
module Refinery
  module Caststone
    module Admin
      class PhotosController < ::Refinery::AdminController
        helper CaststoneHelper

        respond_to :html, :js
        respond_to :json
        # respond_to :png, only: :draw

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

        # def add_copyright
        #   @photo = Refinery::Caststone::Photo.find(params[:id]).image.copyright("Hello Sailor")
        # end
        #

        protected
        def find_all_series
          @products = Refinery::Caststone::Product.all
        end

        def set_view
          if action_name == 'index' && params[:view].present? && Refinery::Caststone::Photos.defined_views.include?(params[:view].to_sym)
            Refinery::Caststone::Photos.preferred_view = params[:view]
          end
        end

        def photo_params
          params.require(:photo).permit(
            :name, :caption, :page, :position,:drawing, :image_id, :page_id, :product_id, :trackid,
            component_ids: [], base_ids: [], shaft_ids: [], capital_ids: [], column_ids: [], letterbox_ids: [])
        end
      end
    end
  end
end
