#require "#{Rails.root}/vendor/extensions/caststone/app/models/refinery/caststone/photo.rb"
module Refinery
  module Caststone
    module Admin
      class PhotosController < ::Refinery::AdminController
        respond_to :html,:js
        respond_to :json
        respond_to :png, :only=>:draw

         before_filter :find_all_series, :only => [:edit, :new]
         # before_filter :find_series_components, :only => [:edit]

        crudify :'refinery/caststone/photo',
                :title_attribute => 'name', :paging => true

          # Finds one single result based on the id params.
          def find_photo
            @photo = Refinery::Caststone::Photo.includes(:product => :components).find(params[:id])
          end

          def add_copyright
            @photo = Refinery::Caststone::Photo.find(params[:id]).image.copyright("Hello Sailor")
          end

        protected
        def find_all_series
          @products = Refinery::Caststone::Product.all
        end
      end
    end
  end
end