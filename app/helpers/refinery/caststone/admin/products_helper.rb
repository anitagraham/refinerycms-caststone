module Refinery
  module Caststone
    module Admin
      module ProductsHelper
        def list_components_by_type(components)
          Rails.logger.debug ". . . . .  listing components by type"
          components_presenter = Refinery::Caststone::Admin::ComponentsPresenter.new(components)
          components_presenter.list_by_type
        end
      end
    end
  end
end
