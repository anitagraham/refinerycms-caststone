Refinery::Admin::PagesController.class_eval do

	before_filter :find_all_caststone_objects , :only => [:create, :edit]

	protected

	  def find_all_caststone_objects
	    @photos = Refinery::Caststone::Photo.order(:name).all
      @series = Refinery::Caststone::Product.all
	  end
end
