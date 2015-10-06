module Refinery
  module Caststone
    class Component < Refinery::Core::BaseModel
      include Rails.application.routes.url_helpers

      dragonfly_accessor :drawing, app: :caststone_components
      # default_scope {where(order: 'name ASC')}
      acts_as_indexed fields: [:name]

      COMP_TYPES = %w(Base Shaft Column Capital Letterbox)

      validates :name, presence: true, uniqueness: true
      validates :type, presence: true
      validates :height, numericality: { only_integer: true, greater_than: 0}, :presence=> true
      validates_presence_of :series, message: "You must choose a series"
      validates_associated :series

      has_many :compatibles
      has_many :series, through: :compatibles, source: :series

      scope :filter_by_series, lambda{ |series_id| includes(:components).where(series: {id: series_id}) }

      def ready
        not(self.drawing_uid.blank? or self.series.empty? or self.height.nil? or self.height==0)
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
          ["Colummn","Refinery::Caststone::Column"],
          ["Letterbox","Refinery::Caststone::Letterbox"],
          ["Shaft","Refinery::Caststone::Shaft"]
        ]
      end

      def thumbnail(geometry = nil)
        if drawing_uid
          if geometry.is_a?(Symbol) and Refinery::Caststone::Photos.sizes.keys.include?(geometry)
            geometry = Refinery::Caststone::Photos.sizes[geometry]
          end

          if geometry.present? && !geometry.is_a?(Symbol)
            drawing.thumb(geometry).url
          else
            drawing.url
          end
        else
          "No drawing found"
        end
    end

      def popup_image
         name self.thumbnail('250x')
      end

      def self.construct(component_list)
#     expects components to be in drawing order, from bottom to top

        require 'rvg/rvg'
        require 'RMagick'
        include Magick

        Magick::RVG.dpi = 90
        return if component_list.nil?
        list = []
        height = 0
        width = 0
        component_list.each do |comp|
          drawing = Magick::Image.read(Refinery::Caststone::Component.where(:id=>comp).first.drawing.file)[0]
          list.push(drawing)
          height += drawing.rows
          width = [width, drawing.columns].max
        end    # getting drawings and calculating drawing size

        #   set up our canvas.
        rvg = Magick::RVG.new(width, height).viewbox(0,0,width,height) do |canvas|
          canvas.g do |grp|
            # canvas.text(10, height-20,
              # "(c) CastStone #{Time.now.year}".styles(:font_family=>'Verdana', :font_size=>55, :fill=>'blue', :font_weight=>'normal', :font_style=>'normal'))
            ypos = height
            list.each do |i|
              xpos = (width - i.columns)/2
              ypos -= i.rows
              grp.image(i, i.columns, i.rows, xpos, ypos)
            end # each drawing item
          end # canvas.group
        end  # canvas

        png = rvg.draw
        png.format = "png"
        Base64.encode64(png.to_blob)    #spit out the png as a base64 encoded string
      end  # drawing

    end  # Class
  end  # Module Caststone
end  # Module Refinery
