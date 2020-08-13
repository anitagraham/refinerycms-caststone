module PhotoView
  def photo_view(photo, view)
    tag.li class: 'photo', id: dom_id(photo) do
      photo.send view <<  actions(photo)
    end
  end

  def list(photo)
    tag.span(photo.tracking_id.presence, class: :tracking_id) << tag.span(photo.name, class: :title)
  end

  def grid(photo)
    if photo.image.present?
      tag.img photo.image.thumbnail({geometry: :index}).url, itle: photo.name, alt: photo.tracking_id
    else
      tag.p "Rebuild image"
    end
  end

  def actions(photo)
    preview = action_icon :preview, photo.image.url, t('view_live_html', scope: 'refinery.caststone.admin.photos') if photo.image.present?
    edit = action_icon :edit, refinery.edit_caststone_admin_photo_path(photo), t('edit', scope: 'refinery.caststone.admin.photos')
    info = action_icon :info, '#', "#{photo.name} has #{photo.components.count} components and is shown on page #{photo.assigned_page_name}"
    delete = action_icon :delete, ""
    preview << edit << info << delete
  end
end