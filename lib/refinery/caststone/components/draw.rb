module Refinery
  module Caststone
    module Components

      class << self
      SCALEX = 200
      SCALEY = 600
    
  
        
        def draw(items, *scaling)
          width = scaling[0] || SCALEX
          height = scaling[1] || SCALEY
          ap "Drawing #{items} at #{width}x#{height}"
          Magick::RVG.dpi = 90
      
          # if items.isa? String # assume here a comma separated list of component ids
            # items = items.split(",")
          # end
      
          #   set up our canvas. FTM, use absolute max width, height in pixels
          rvg = Magick::RVG.new(SCALEX, SCALEY).viewbox(0,0,width,height) do |canvas|
            canvas.g do |grp|
              ypos = height
      
              items.each do |i|
                # drawing = Refinery::Caststone::Components.find(c).drawing
                drawing = self.find(i).drawing
                img = Magick::Image.read(drawing.file )[0]
                xpos= (width-img.columns)/2
                ypos -= img.rows
                grp.image(img,img.columns,img.rows,xpos,ypos)
              end
            end  # canvas.g do
          end  # rvg.new do
      
          png = rvg.draw
          png.format = "png"
         Base64.encode64(png.to_blob)    #spit out the png as a base64 encoded string
        end
        
      end
      
    end
  end
end
