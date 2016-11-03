#require "#{Rails.root}/vendor/extensions/caststone/app/models/refinery/caststone/photo.rb"
module Refinery
  module Caststone
    module Admin
      class PhotosController < ::Refinery::AdminController
      	helper Refinery::Caststone::Engine.helpers

        respond_to :html,:js
        respond_to :json
        respond_to :png, :only=>:draw

	      before_action :change_list_mode_if_specified
        before_filter :find_all_series, :only => [:edit, :new]

        crudify :'refinery/caststone/photo',
                :title_attribute => 'name', :paging => true

        # Finds one single result based on the id params.
        def find_photo
          @photo = Refinery::Caststone::Photo.includes(:product => :components).find(params[:id])
        end

        def add_copyright
          @photo = Refinery::Caststone::Photo.find(params[:id]).image.copyright("Hello Sailor")
        end

	      def change_list_mode_if_specified
	        if action_name == 'index' && params[:view].present? && Refinery::Caststone::Photos.photo_views.include?(params[:view].to_sym)
	           Refinery::Caststone::Photos.preferred_photo_view = params[:view]
	        end
	      end

        protected
        def find_all_series
          @products = Refinery::Caststone::Product.all
        end

        def photo_params
          params.require(:photo).permit(:name, :caption,  :page, :position, :drawing, :image, :page_id, :product_id,
                                        component_ids: [], base_ids: [], shaft_ids: [], capital_ids: [], column_ids: [], letterbox_ids: [])
        end
      end
    end
  end
end