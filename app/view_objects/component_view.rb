class ComponentView
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::AssetTagHelper

  I18N_SCOPE = 'address_object'
  attr_accessor :name, :type, :height, :drawing, :products, :output_buffer

  def initialize(component)
    @name = component.name
    @type = component.type
    @height = component.height
    @drawing = component.drawing.presence
    @products = component.products
  end


  def to_html(view)
    markup = case view
      when 'list'
        list_view
      when 'grid'
        grid_view
    end
    tag.li id: id, class: type.demodulize do
      markup << actions
    end
  end

  private

    def grid_view
      image = drawing.present? ? image(drawing) : (tag.p "No Drawing")
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
      edit = action_icon :edit, refinery.edit_caststone_admin_component_path(id), t('.edit')
      delete = action_icon :delete, refinery.caststone_admin_component_path(id), t('.delete'), class: 'cancel confirm-delete',
                           data: {confirm: t('message', scope: 'refinery.admin.delete', title: component.name)}
      tag.div class: :actions do
        edit << delete
      end
    end
end


