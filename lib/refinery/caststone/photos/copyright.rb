class Copyright
  include Dragonfly::Configurable
  include Dragonfly::ImageMagick::Utils

  def copyright(source_image, notice = "(c)")
#     opts = defaults.merge(opts)
# #TODO proper tempfile name
#     tempfile =Tempfile.new('caststone')
#     command = "convert  -fill white -pointsize 40 -annotate 0 'Hello Sailor' #{source_image.path} #{tempfile.path}"
#     result = `#{command}`
#     tempfile
  end

    def defaults
    { opacity: 60,
      pointSize: 24,
      fontFamily: 'Baskerville',
      fontWeight: 'bold',
      gravity: 'southwest',
      stroke: 'transparent',
      fill: 'white',
      text: "\"(c) Caststone  #{Time.now.year}\""
    }
  end
end
