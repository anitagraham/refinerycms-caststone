module Refinery
  module Caststone
    class ComponentsController < ::ApplicationController
       respond_to :png, :only => :draw
       def draw                 
         send_data  Refinery::Caststone::Component.construct(params[:list]), :type => 'image/png', :disposition => 'inline'
       end      
    end
  end
end