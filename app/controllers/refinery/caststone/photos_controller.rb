# require "#{Rails.root}/vendor/extensions/caststone/app/models/refinery/caststone/Photo.rb"
module Refinery
  module Caststone
    class PhotosController < ::ApplicationController
      before_action :get_products, only: [:new, :edit]
      respond_to :js, only: :details
      respond_to :png, only: :draw
      respond_to :json

      def draw
        send_data  CaststoneHelper.drawing(params[:component_list]), type: 'image/png', disposition: 'inline'
      end
      
      def details
        photo =  Refinery::Caststone::Photo.find(params[:id])
        if photo.components.empty?
          render nothing: true, status: 204
        else
          @photo = photo
        end
      end
      private

    end
  end
end

