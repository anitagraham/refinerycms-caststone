# config/initializers/preload_sti_models.rb
if Rails.env.development?
  # # Make sure we preload the parent and children classes in development
  # %w[Component Base Capital Column Letterbox Shaft].each do |c|
    # require_dependency File.join("vendor/extensions/caststone/app/models/refinery/caststone/","#{c}.rb")
  # end
end