Refinery::Admin::PagesController.prepend(
  Module.new do
    def permitted_page_params

      params[:page][:photo_ids].nil? ? {} : params[:page][:photo_ids].compact
      super <<  [photo_ids: []]
    end
  end
)
Refinery::Admin::PagesController.class_eval do

  # work around an issue with stack level too deep, due to an issue with decorators.
  if self.instance_methods.exclude?(:page_params_with_photo_params)
    # We need to add photos attributes to page_params as it is ignored by strong parameters. (See #100)
    def page_params_with_photo_params

      # Get the :images_attributes hash from params
      photo_params = params.require(:page).permit(:photos_show, :photos_count, :photos_select)
      page_params_without_photo_params.merge(photo_params)

    end

    # Swap out the default page_params method with our new one
    alias_method_chain :page_params, :photo_params
  end


	protected

	  def find_all_caststone_objects
	    @photos = Refinery::Caststone::Photo.order(:name).all
      @series = Refinery::Caststone::Product.all
	  end

end
