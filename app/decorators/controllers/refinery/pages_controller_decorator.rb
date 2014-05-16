Refinery::Admin::PagesController.class_eval do

	before_filter :find_all_caststone_objects #, :only => [:create, :edit]

	protected

	  def find_all_caststone_objects
	  	logger.debug "============= Find all caststone objects ============"
	    @photos = Refinery::Caststone::Photo.order(:name).all
	    logger.debug "============= #{@photos.count} photos found ============"
      # @components = Refinery::Caststone::Component.all
      @series = Refinery::Caststone::Product.all
	    logger.debug "============= #{@series.count} series found ============"
	  end
end
