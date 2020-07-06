module AdminComponentsHelper
  def index_view(component, view)
    markup = case view
      when 'list'
        list_view(component)
      when 'grid'
        grid_view(component)
    end

    tag.li id: component.id, class: component.type.demodulize do
      markup << actions(component)
    end

  end

  private

    def grid_view(component)
      drawing = tag.img src: component&.drawing.thumb({geometry: :index}).url, title: component.name, alt: component.name
      info = tag.span do
        "#{component.name} (#{component&.height}mm), #{component.products}"
      end
      drawing << info
    end

    def list_view(component)
      %w[name height products].map { |attr| tag.span component.send(attr) }.join('')
    end

    def actions(component)
      edit = action_icon :edit, refinery.edit_caststone_admin_component_path(component), t('.edit')
      delete = action_icon :delete, refinery.caststone_admin_component_path(component), t('.delete'), class: 'cancel confirm-delete',
                           data: {confirm: t('message', scope: 'refinery.admin.delete', title: component.name)}
      tag.div class: :actions do
        edit << delete
      end
    end
end



