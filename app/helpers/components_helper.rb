module Refinery::Caststone::Admin::ComponentsHelper

  def drawing
    maxh = 600
    maxw = 200
    scalex = 200
    scaley = 435
    require 'rvg/rvg'
    Magick::RVG.dpi = 90
    #   set up our canvas. FTM, use absolute max width, height in pixels
    rvg = Magick::RVG.new(scalex, scaley).viewbox(0,0,maxw,maxh) do |canvas|
      canvas.g do |grp|
        ypos = maxh

        @components.each do |comp|
            drawing = Refinery::Caststone::Component.find(comp).drawing
            img = Magick::Image.read(drawing.file )[0]
            xpos= (maxw-img.columns)/2
            ypos -= img.rows
            grp.image(img,img.columns,img.rows,xpos,ypos)

        end  #of list.each do
      end  # canvas.g do
    end  # rvg.new do

    png = rvg.draw
    png.format = "png"
    Base64.encode64(png.to_blob)    #spit out the png as a base64 encoded string
  end  # drawing
  
    

end
