# encoding: utf-8
Refinery::Images.configure do |config|

  #  Refinery::Images configuration

  # Configures the maximum allowed upload size (in bytes) for an image
  # config.max_image_size = 5242880

  # Configure how many images per page should be displayed when a dialog is presented that contains images
  # config.pages_per_dialog = 18

  # Configure how many images per page should be displayed when a dialog is presented that
  # contains images and image resize options
  # config.pages_per_dialog_that_have_size_options = 12

  # Configure how many images per page should be displayed in the list of images in the admin area
  # config.pages_per_admin_index = 20

  # Configure image sizes
  # config.user_image_sizes = {small:"110x110>", medium:"225x255>", large:"450x450>"}

  # Configure image ratios
  # config.user_image_ratios = {:"16/9"=>"1.778", :"4/3"=>"1.333", :"1:1"=>1}

  # Configure allowed mime types for validation
  config.whitelisted_mime_types = ["image/jpeg", "image/png"]

  # Configure image view options
  # config.image_views = [:grid, :list]

  # Configure default image view
  # config.preferred_image_view = :grid

  # Configure Dragonfly.
  # Refer to config/initializers/refinery/dragonfly.rb for the full list of dragonfly configurations which can be used.
  # This includes all dragonfly config for Dragonfly v 1.1.1

  config.dragonfly_name = :refinery_images


end
