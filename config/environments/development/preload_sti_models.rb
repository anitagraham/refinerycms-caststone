# config/initializers/preload_sti_models.rb
%w[Component Base Capital Column Letterbox Shaft] if Rails.env == 'development'