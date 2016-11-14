Refinery::Admin::PagesController.prepend(
  Module.new do
    def permitted_page_params

      params[:page][:photo_ids].nil? ? {} : params[:page][:photo_ids].compact
      super <<  [photo_ids: []]
    end
  end
)
Refinery::Admin::PagesController.class_eval do

	protected

	  def find_all_caststone_objects
	    @photos = Refinery::Caststone::Photo.order(:name).all
      @series = Refinery::Caststone::Product.all
	  end

end
