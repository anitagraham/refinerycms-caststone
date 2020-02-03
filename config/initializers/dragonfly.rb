# Commenting out whole file as this should be done at the app level and not at the gem
#Refinery::Dragonfly.configure do |config|
#  # Configure S3 (you can also use ENV for this)
#  # The s3_backend setting by default defers to the core setting for this but can be set just for images.
#
#  config.s3_backend = true
#  config.s3_bucket_name = Rails.application.credentials.aws[:s3_bucket]
#  config.s3_access_key_id = Rails.application.credentials.aws[:s3_access_key_id]
#  config.s3_secret_access_key = Rails.application.credentials.aws[:s3_secret_access_key]
#  config.s3_region = Rails.application.credentials.aws[:s3_region]
#  #
#  # Configure Dragonfly
#  # Dragonfly processor add a copyright statement to an image (imagemagick conversion -annotate)
#  add_copyright_command = "-gravity southeast -pointsize 16px -fill white -annotate 0 '(c) www.caststone.com.au #{Time.now.year}'"
#  config.dragonfly_processors = {
#                                   name: :copyright,
#                                   block: -> (content) { content.process!(:convert, add_copyright_command) }
#                                 }
#  config.dragonfly_secret =  "d710e4d32b6a170f9be4207acb87d08c518f1cf4242eed11"
#end
