require 'refinerycms-core'
require 'dragonfly'
require 'rack/cache'

module Refinery
  autoload :CaststoneGenerator, 'generators/refinery/caststone_generator'

  module Components
    require 'refinery/caststone/components/engine'
    require 'refinery/caststone/components/configuration'
    autoload :Dragonfly, 'refinery/caststone/components/dragonfly'
    

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end
