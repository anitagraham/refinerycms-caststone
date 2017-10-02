Refinery::Admin::DialogsController::TYPES << 'cta'
Refinery::Admin::DialogsController.prepend(
  Module.new do
    def find_iframe_src
      if @dialog_type == 'cta'
        @iframe_src = refinery.cta_path url_params.merge(:dialog => true)
      else
        super
      end
    end
  end
)
