Refinery::Pages::Admin::PreviewController.prepend(
  Module.new do
    def permitted_page_params
      super <<  [photo_ids: []]
    end

    protected
  end
)
