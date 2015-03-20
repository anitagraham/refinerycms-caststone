Refinery::Admin::PagesController.class_eval do

	before_filter :find_all_caststone_objects , :only => [:create, :edit]

  def page_params_with_photo_params

    photo_params = params.require(:page).permit(photo_ids:[])
    page_params_without_photo_params.merge(photo_params)

  end

  # Swap out the default page_params method with our new one
  alias_method_chain :page_params, :photo_params


	protected

	  def find_all_caststone_objects
	    @photos = Refinery::Caststone::Photo.order(:name).all
      @series = Refinery::Caststone::Product.all
	  end

end
