module Refinery
  module Caststone
    class TemplatesController < ::ApplicationController
      respond_to :mustache

      def serve
        Rails.logger.debug(". . . . #{__FILE__}/#{__method__}")
        render file: "#{Rails.root}/public/templates/#{params[:path]}/#{params[:name]}.mustache", layout: false
      end
    end
  end
end
