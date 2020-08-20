module Refinery
  module Caststone
    module Admin
      module ProductsHelper
        def list_components_by_type(components)
          components_presenter = Refinery::Caststone::Admin::ComponentsPresenter.new(components)
          components_presenter.list_by_type
        end
      end
    end
  end
end
