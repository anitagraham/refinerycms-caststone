module Refinery
  module Caststone
    class TemplatesController < ::ApplicationController
      respond_to :mustache

      def serve
        
        render :file => "#{Rails.root}/public/templates/#{params[:path]}/#{params[:name]}.mustache", :layout => false
      end
    end
  end
end