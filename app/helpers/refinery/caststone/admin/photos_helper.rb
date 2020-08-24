module Refinery
  module Caststone
    module Admin
      module PhotosHelper
        def index_view(photo, view)
          status = photo.complete ? 'good' : 'warning'
          tag.li class: "photo #{status}" , id: dom_id(photo) do
            photo.send view <<  actions(photo)
          end
        end

        def list(photo)
          [tag.span(photo.photo_number.presence, class: :photo_number), tag.span(photo.name, class: :title)].join('/').html_safe
        end

        def grid(photo)
          if photo.image.present?
            tag.img photo.image.thumbnail({geometry: :index}).url, itle: photo.name, alt: photo.photo_number
          else
            tag.p "Rebuild image"
          end
        end

        def actions(photo)
          preview = ''
          preview = action_icon :preview, photo.image.url, t('view_live_html', scope: 'refinery.caststone.admin.photos') if photo.image.present?
          edit = action_icon :edit, refinery.edit_caststone_admin_photo_path(photo), t('edit', scope: 'refinery.caststone.admin.photos')
          info = action_icon :info, '#', "#{photo.name} has #{photo.components.count} components and is shown on page #{photo.assigned_page_name}"
          delete = action_icon :delete, ""
          # state = get_status(photo)
          edit << info << delete << preview
        end
      end
    end
  end
end
