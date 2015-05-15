Refinery::Admin::PagesController.class_eval do

	before_filter :find_all_caststone_objects , :only => [:create, :edit]

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
