module CaststoneHelper

  class NoDrawing < StandardError
  end

  def self.drawing(component_ids)
    return if component_ids.nil? || component_ids.count.zero?

    maxh = 600
    maxw = 200
    # scalex = 200
    scaley = 0.3
    require 'rvg/rvg'
    Magick::RVG.dpi = 90

    components = Refinery::Caststone::Component.find(component_ids)
    height = components.map(&:height).reduce(:+) * scaley

    #   set up our canvas. Use max width, actual height in mm => pixels, scaled down
    rvg = Magick::RVG.new(maxw, height).viewbox(0, 0, maxw, height) do |canvas|
      canvas.g do |grp|
        ypos = height

        components.each do |comp|
          begin
            drawing = comp.drawing
            raise NoDrawing if drawing.nil?
            img = Magick::Image.read(drawing.file)[0]
            xpos = (maxw - img.columns) / 2
            ypos -= img.rows
            grp.image(img, img.columns, img.rows, xpos, ypos)
          rescue
            NoDrawing
            Rails.logger.error "Component #{comp.name} has no drawing"
            next
          end
        end #of list.each do
      end # canvas.g do
    end # rvg.new do

    png = rvg.draw
    png.format = "png"
    Base64.encode64(png.to_blob) #spit out the png as a base64 encoded string
  end

  def other_photo_views
    Refinery::Caststone::Photos.defined_views.reject do |image_view|
      image_view.to_s == Refinery::Caststone::Photos.preferred_view.to_s
    end
  end


  def self.to_slug(*segments)
    [segments].join('_').gsub(/\W/, '').downcase
  end

  def self.to_id(*segments)
    "#" << CaststoneHelper.to_slug(*segments)
  end

  def photo_index_view(photo, view)
    status = photo.complete? ? "ok" : "warning"
    link = edit_link(photo, view)
    photo_number = photo.photo_number.present? ? (tag.span photo.photo_number, class: :photo_number) : nil
    actions = tag.span actions(photo), class: [:actions, status]

    tag.li class: ["photo", status], id: dom_id(photo) do
      [photo_number, link, actions].join(' ').html_safe
    end
  end

  def edit_link(photo, view)
    image = view == 'list' ? list(photo) : grid(photo)
    link_to image, refinery.edit_caststone_admin_photo_path(photo), class: :edit, title: 'Click to edit'
  end

  def list(photo)
    tag.span(photo.name, class: :title)
  end

  def grid(photo)

    if photo.image.present?
      tag.img src: photo.image.thumbnail({ geometry: :index }).url,
              title: "#{photo.name} (#{photo.image&.photo_number})",
              alt: photo.photo_number
    else
      tag.p "No image attached"
    end
  end

  def actions(photo)
    preview_link = ''
    preview_link = action_icon :preview, photo.image.url, t('view_live_html', scope: 'refinery.caststone.admin.photos') if photo.complete?
    edit_link = action_icon :edit, refinery.edit_caststone_admin_photo_path(photo), t('edit', scope: 'refinery.caststone.admin.photos')
    delete_link = action_icon :delete, refinery.caststone_admin_photo_path(photo), "Delete", class: 'cancel confirm-delete',
                              data: { confirm: "Do your really want to delete #{photo.name}" }
    info_icon = action_icon :info, '#',
                            "#{photo.name}/(#{photo.photo_number}) components: #{photo.component_count} Page: #{photo.assigned_page_name}"
    edit_link << info_icon << delete_link << preview_link
  end

  def component_index_view(collection)
    presenter = Refinery::Caststone::ComponentPresenter.new(collection, self)
    presenter.to_html
  end

end



