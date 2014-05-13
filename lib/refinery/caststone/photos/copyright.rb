class Copyright
  include Dragonfly::Configurable
  include Dragonfly::ImageMagick::Utils

  def copyright(source_image, notice = "(c)")
    opts = defaults.merge(opts)
    tempfile =Tempfile.new('ANITA')
    command = "convert  -fill white -pointsize 40 -annotate 0 'Hello Sailor' #{source_image.path} #{tempfile.path}"
    result = `#{command}`
    tempfile

    # convert(source_image, " -fill white -pointsize 40 -annotate 0 'Hello Sailor'")
  end

    def defaults
    { opacity: 60,
      pointSize: 24,
      fontFamily: 'Baskerville',
      fontWeight: 'bold',
      gravity: 'southwest',
      stroke: 'transparent',
      fill: 'white',
      text: '"(c) Caststone  #{Time.now.year}"'
    }
  end
end
#     source_image is a dragonfly TempObject
    # opts = defaults.merge(opts)

    # tempfile = new_tempfile
    # ap "---------------------------"
    # ap tempfile.path
    # ap "---------------------------"
    # args = " -fill white -gravity north -pointsize 40 -annotate 0 '#{notice}' #{source_image.path} #{tempfile.path}"
    # full_command = "convert #{args}"
    # result = `#{full_command}`
    # tempfile

    # mark = Magick::Draw.new
    # src = Magick::Image.read(source_image.file)[0]
    # ap "Source is #{source_image}"
    # ap "Mark is #{mark}"
    # ap "Src is #{src}"
    # mark.annotate(src, 0,0,0,0, "(c) CastStone  #{Time.now.year}") {opts}
    # convert source_image.file  -fill white   -annotate +10+141 'text'  anno_dim_draw.jpg
    # args = Array.new
    # opts.each  {|key, value|
      # args << "-#{key} #{value}" unless key==='text'
    # }
    # ap "---------------------------"
    # ap args
    # ap "---------------------------"
    # args << "-gravity #{opts.gravity}"
    # args << "-opacity"
    # options = args.join(' ')
    # ap options
    # convert source_image, "#{options} #{opts.text}"
    # tempfile = new_tempfile
    # args = " -compose atop -geometry +0+0 -resize 75x73 lib/bottletop_overlay.png #{temp_object.path} #{tempfile.path}"
    # Magick.convert(source_image, "-gravity southeast -fill white -annotate 0 #{mark}")
    # mark.annotate(src, 0, 0, 0, 0, notice)

    # source_image.file.convert('-gravity southeast', '-fill white', '-annotate 0 ', mark)
  # end

  # def defaults
    # { opacity: 60,
      # pointSize: 24,
      # fontFamily: 'Baskerville',
      # fontWeight: 'bold',
      # gravity: 'southwest',
      # stroke: 'transparent',
      # fill: 'white',
      # text: '"(c) Caststone  #{Time.now.year}"'
    # }
  # end
#
  # private
  # def new_tempfile(ext=nil)
    # tempfile = ext ? Tempfile.new(['dragonfly', ".#{ext}"]) : Tempfile.new('dragonfly')
    # tempfile.binmode
    # tempfile.close
    # tempfile
  # end


# end

# convert("-gravity south -fill white -annotate 0 'Copyright: © Author'").url # convert(# source_image,
# "( #{opts[:watermark]} -resize #{watermark_resize} ) -compose dissolve -define compose:args=#{opts[:opacity]} -composite"
# )
     # rmagick_image(source_image) do |image|
          # image.composite(src, Magick::CenterGravity, Magick::OverCompositeOp)
    # end
    # convert(source_image, "-gravity southwest -fill white -annotate 0 '(c) CastStone #{Time.now.year}'")
    # source_image.watermark(mark, 1, 1, "Southwest")
    # tempfile = new_tempfile
    # args = " -compose atop -geometry +0+0 -resize 75x73 lib/bottletop_overlay.png #{temp_object.path} #{tempfile.path}"
    # full_command = "composite #{args}"
    # result = `#{full_command}`
    # tempfile
    # mark
