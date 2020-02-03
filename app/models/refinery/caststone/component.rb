module Refinery
  module Caststone
    class Component < Refinery::Core::BaseModel
      include Rails.application.routes.url_helpers

      dragonfly_accessor :drawing, app: :caststone_components
      acts_as_indexed fields: [:name]

      COMP_TYPES = %w(Base Shaft Column Capital Letterbox)

      validates :name, presence: true, uniqueness: true
      validates :type, presence: true
      validates :height, numericality: { only_integer: true, greater_than: 0}, presence: true
      #alias :component_type :type

      has_many :compatibles
      has_many :products, through: :compatibles, source: :product

      def ready
        self.drawing.present? && self.product.present? && self.height.positive?
      end

      def to_s
        name
      end

      def self.inherited(child)
      child.instance_eval do
        alias :original_model_name :model_name
        def model_name
          Component.model_name
        end
      end
        super
      end

      def self.select_options
        [
          ["Base","Refinery::Caststone::Base"],
          ["Capital","Refinery::Caststone::Capital"],
          ["Column","Refinery::Caststone::Column"],
          ["Letterbox","Refinery::Caststone::Letterbox"],
          ["Shaft","Refinery::Caststone::Shaft"]
        ]
      end

      def popup_image
         name self.thumbnail('250x')
      end

#      def self.construct(component_list)
##     expects components to be in drawing order, from bottom to top
#
#        require 'rvg/rvg'
#        require 'rmagick'
#        include Magick
#
#        Magick::RVG.dpi = 90
#        return if component_list.nil?
#        list = []
#        height = 0
#        width = 0
#        component_list.each do |comp|
#          drawing = Magick::Image.read(Refinery::Caststone::Component.where(id:comp).first.drawing.file)[0]
#          list.push(drawing)
#          height += drawing.rows
#          width = [width, drawing.columns].max
#        end    # getting drawings and calculating drawing size
#
#        #   set up our canvas.
#        rvg = Magick::RVG.new(width, height).viewbox(0,0,width,height) do |canvas|
#          canvas.g do |grp|
#            # canvas.text(10, height-20,
#              # "(c) CastStone #{Time.now.year}".styles(font_family:'Verdana', font_size:55, fill:'blue', font_weight:'normal', font_style:'normal'))
#            ypos = height
#            list.each do |i|
#              xpos = (width - i.columns)/2
#              ypos -= i.rows
#              grp.image(i, i.columns, i.rows, xpos, ypos)
#            end # each drawing item
#          end # canvas.group
#        end  # canvas
#
#        png = rvg.draw
#        png.format = "png"
#        Base64.encode64(png.to_blob)    #spit out the png as a base64 encoded string
#      end  # drawing

    end  # Class
  end  # Module Caststone
end  # Module Refinery
