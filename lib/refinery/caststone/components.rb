require 'refinerycms-core'
require 'dragonfly'

module Refinery
  autoload :CaststoneGenerator, 'generators/refinery/caststone_generator'
  module Caststone
    module Components
      require 'refinery/caststone/components/engine'
      require 'refinery/caststone/components/configuration'
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