require 'refinerycms-core'

module Refinery
  autoload :CaststoneGenerator, 'generators/refinery/caststone_generator'
  module Caststone

    module Products
      require 'refinery/caststone/products/engine'
      autoload :Tab, 'refinery/caststone/products/tabs'

      USES = {
        # for each product type, valid component types
        column: [:base, :column, :capital],
        group: [],
        letterbox: [:base, :shaft, :capital, :letterbox],
        pillar: [:base, :shaft, :capital],
        trim: [:base, :shaft, :trim],
      }.freeze

      class << self
        attr_writer :root

        def root
          @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
        end

        def tabs
          @tabs ||= []
        end

        def factory_paths
          @factory_paths ||= [root.join('spec', 'factories').to_s]
        end

      end
    end
  end
end
