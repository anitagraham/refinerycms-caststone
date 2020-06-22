module Refinery
  module Caststone
    module Photos

      extend Refinery::Dragonfly::ExtensionConfiguration
      include ActiveSupport::Configurable

      config_accessor :defined_views,
                      :max_image_size,
                      :pages_per_admin_index,
                      :pages_per_dialog,
                      :pages_per_dialog_that_have_size_options,
                      :permitted_mime_types,
                      :preferred_view,
                      :sizes

      self.dragonfly_name         = :caststone_photos
      self.dragonfly_plugin       = :imagemagick

      # Dragonfly processor to strip image of all profiles and comments
      # (imagemagick conversion -strip)
      self.dragonfly_processors = [{
        name: :strip,
        block: ->(content) { content.process!(:convert, '-strip') }
      }]
      config.dragonfly_url_format = '/system/refinery/photos/:job/:basename.:ext'
      #self.dragonfly_url_format = Refinery::Dragonfly.url_format('photos')

      self.max_image_size = 5242880
      self.pages_per_dialog = 18
      self.pages_per_dialog_that_have_size_options = 12
      self.pages_per_admin_index = 20
      self.sizes = {
        #        % Interpret width and height as a percentage of the current size.
        #        ! Resize to width and height exactly, losing original aspect ratio.
        #        < Resize only if the image is smaller than the geometry specification.
        #        > Resize only if the image is greater than the geometry specification,
        index: '140x140',
        edit: '500x500'
      }

      self.defined_views = %i[grid list]
      self.preferred_view = :grid

    end
  end
end
