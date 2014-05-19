require 'refinerycms-core'
require 'dragonfly'
require 'rack/cache'

module Refinery
  module Caststone
    module Photos
      autoload :CaststoneGenerator, 'generators/refinery/caststone_generator'
      require 'refinery/caststone/photos/engine'
      require 'refinery/caststone/photos/extension'
      require 'refinery/caststone/photos/configuration'
      require 'refinery/caststone/photos/copyright'

      autoload :Dragonfly, 'refinery/caststone/photos/dragonfly'

      class << self
        def root
          @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
        end

        def factory_paths
          @factory_paths ||= [ root.join("spec/factories").to_s ]
        end
      end
    end
  end
end
