require 'refinerycms-core'
require 'dragonfly'

module Refinery
  autoload :CaststoneGenerator, 'generators/refinery/caststone_generator'
  module Caststone
    module Photos
      require 'refinery/caststone/photos/engine'
      require 'refinery/dragonfly/extension_configuration'
      require 'refinery/caststone/photos/configuration'

      class << self
        def root
          @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
        end

        def factory_paths
          @factory_paths ||= [ root.join('spec', 'factories').to_s ]
        end
      end
    end
  end
end
