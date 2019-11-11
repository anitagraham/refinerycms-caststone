Refinery::Admin::PagesController.prepend(
  Module.new do
    def permitted_page_params
      params[:page][:photo_ids].nil? ? {} : params[:page][:photo_ids].compact
      super <<  [photo_ids: []]
    end

    protected
  end
)
