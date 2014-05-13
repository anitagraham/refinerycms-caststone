Refinery::Core.configure do |config|
  # Register extra javascript for backend
  config.register_javascript "extension"

  # Register extra stylesheet for backend (optional options)
  config.register_stylesheet "caststone", :media => 'screen'
end