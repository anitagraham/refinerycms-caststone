
class ComponentView < SimpleDelegator
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::AssetTagHelper
  include Refinery::TagHelper
  include ViewHelpers

  attr_accessor :output_buffer

  def initialize(collection, context)
    @collection = collection
    @context = context
  end

  def to_html
    view_name =  Refinery::Caststone::Components.preferred_view
    markup = case view_name
      when :list
        list_view
      when :grid
        grid_view
    end
    tag.li id: id, class: type.demodulize do
      markup << actions
    end
  end

  private

    def grid_view
      # image = drawing ? image(drawing) : (tag.p "No Drawing")
      info = tag.span do
        "#{name} (#{height}mm), #{products}"
      end
      image << info
    end

    def list_view
      %w[name height products].map { |attr| tag.span self.attr }.join('')
    end

    def image(drawing)
      tag.img src: drawing.thumb({geometry: :index}).url, title: name, alt: name
    end

    def actions
      edit = action_icon :edit, refinery.edit_caststone_admin_component_path(id), 'Edit'
      delete = action_icon :delete, refinery.caststone_admin_component_path(id), "Delete", class: 'cancel confirm-delete',
                           data: {confirm: "Do your really want to delete #{component.name}"}
      tag.div class: :actions do
        edit << delete
      end
    end
end


