module CaststoneHelper
  def other_photo_views
    Refinery::Caststone::Photos.defined_views.reject do |image_view|
      image_view.to_s == Refinery::Caststone::Photos.preferred_view.to_s
    end
  end

  def self.drawing(component_ids)
    return if component_ids.count.zero?
    maxh = 600
    maxw = 200
    # scalex = 200
    scaley = 0.3
    require 'rvg/rvg'
    Magick::RVG.dpi = 90

    components = Refinery::Caststone::Component.find(component_ids)
    height = components.map(&:height).reduce(:+)

    #   set up our canvas. Use max width, actual height in mm => pixels
    rvg = Magick::RVG.new(maxw, height).viewbox(0, 0, maxw, height) do |canvas|
      canvas.g do |grp|
        ypos = height

        components.each do |comp|
          drawing = comp.drawing
          img = Magick::Image.read(drawing.file)[0]
          xpos = (maxw - img.columns) / 2
          ypos -= img.rows
          grp.image(img, img.columns, img.rows, xpos, ypos)

        end #of list.each do
      end # canvas.g do
    end # rvg.new do

    png = rvg.draw
    png.format = "png"
    Base64.encode64(png.to_blob) #spit out the png as a base64 encoded string
  end # drawing

  def self.to_slug(*segments)
    [segments].join('_').gsub(/\W/, '').downcase
  end
  def self.to_id(*segments)
    "#" << CaststoneHelper.to_slug(*segments)
  end

  def photo_index_view(photo, view)
    image = view == 'list' ? list(photo) : grid(photo)
    icons = tag.span actions(photo), class: :actions
    tag.li class: 'photo', id: dom_id(photo) do
      image << icons
    end
  end

  def list(photo)
    tag.span(photo.trackid.presence, class: :trackid) << tag.span(photo.name, class: :title)
  end

  def grid(photo)
    if photo.image.present?
      tag.img src: photo.image.thumbnail({geometry: :index}).url, title: "#{photo.name} (#{photo.image&.trackingId})", alt: photo&.trackid
    else
      tag.p "Rebuild image"
    end
  end

  def actions(photo)
    preview = action_icon :preview, photo.image.url, t('view_live_html', scope: 'refinery.caststone.admin.photos') if photo.image.present?
    edit = action_icon :edit, refinery.edit_caststone_admin_photo_path(photo), t('edit', scope: 'refinery.caststone.admin.photos')
    info = action_icon :info, '#',
           "#{photo.name}/(#{photo.trackid}) components: #{photo.component_count} Page: #{photo.assigned_page_name}"
    edit << info <<  preview
  end

  def component_index_view(collection)
    presenter = Refinery::Caststone::ComponentPresenter.new(collection, self)
    presenter.to_html
  end

end



