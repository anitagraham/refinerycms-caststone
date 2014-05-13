require 'refinerycms-core'
require 'dragonfly'
require 'rack/cache'

module Refinery
  autoload :CaststoneGenerator, 'generators/refinery/caststone_generator'

  module Photos
    require 'refinery/caststone/photos/engine'
    require 'refinery/caststone/photos/extension'
    require 'refinery/caststone/photos/configuration'
    require 'refinery/caststone/photos/copyright'

    autoload :Dragonfly, 'refinery/caststone/photos/dragonfly'

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
