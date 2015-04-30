# require "#{Rails.root}/vendor/extensions/caststone/app/models/refinery/caststone/Photo.rb"
module Refinery
  module Caststone
    class PhotosController < ::ApplicationController
      respond_to :js, only: :details
      respond_to :png, only: :draw
      respond_to :json

      def details
        photo =  Refinery::Caststone::Photo.find(params[:id])
        if photo.components.empty?
        	render nothing: true, status: 204
        else
          @photo = photo.as_json( include: :components)
        end
      end

    end
  end
end

