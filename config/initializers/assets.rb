Refinery::Core.configure do |config|
  # Register extra javascript for backend
  config.register_javascript "refinerycms-caststone.js"

  # Register extra stylesheet for backend (optional options)
  config.register_stylesheet "refinerycms-caststone.css", media: 'screen'
end
Rails.application.config.assets.precompile += %w( refinerycms-caststone.css refinerycms-caststone.js )
