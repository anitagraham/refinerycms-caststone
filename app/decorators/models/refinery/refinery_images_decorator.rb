# Open the Refinery::Images model for more configuration
Refinery::Images.class_eval do
  config_accessor :backend_image_sizes
  self.backend_image_sizes = {}
end
