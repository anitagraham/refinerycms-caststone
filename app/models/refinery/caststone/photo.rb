module Refinery
  module Caststone
    class Photo < Refinery::Core::BaseModel
      ::Refinery::Caststone::Photos::Dragonfly.setup!
      include Rails.application.routes.url_helpers
      include ActionView::Helpers::UrlHelper
      scope :by_series, order(:product_id)
      default_scope order(:name)

      acts_as_indexed :fields => [:title, :caption]
      alias_attribute :title, :name

      validates :name, :presence => true, :uniqueness => true
      dragonfly_accessor :image, app: :caststone_photos

      belongs_to :product
      belongs_to :page, :inverse_of => :photos,  :foreign_key => 'page_id'
      # validates_presence_of :page


      has_many :assignments
      has_many :components,  :through => :assignments
      has_many :bases,       :through => :assignments, :foreign_key=>'component_id'
      has_many :shafts,      :through => :assignments, :foreign_key=>'component_id'
      has_many :capitals,    :through => :assignments, :foreign_key=>'component_id'
      has_many :columns,     :through => :assignments, :foreign_key=>'component_id'
      has_many :letterboxes, :through => :assignments, :foreign_key=>'component_id'

      before_destroy {|photo| photo.components.clear}
      before_update :save_drawing
      before_save   :save_drawing

      self.per_page = 30

      def as_json(options={})
        json = super(options)
        json['src'] = thumbnail(options[:size])    #thumbnail returns a url
        json['imageurl'] = copyright_image.url
        json['label'] = caption || name
        json
      end

      def height
        self.components.sum(:height)
      end

      def Label
        caption || name
      end

      def ready?
        components.count>0
      end

      def imageurl
        image.url
      end

      def thumbnail(geometry = nil)
        if geometry.is_a?(Symbol) and Refinery::Caststone::Photos.sizes.keys.include?(geometry)
          geometry = Refinery::Caststone::Photos.sizes[geometry]
        end

        if geometry.present? && !geometry.is_a?(Symbol)
          # copyright_image.thumb(geometry).url
          image.thumb(geometry).url
        else
          # copyright_image.url
          image.url
        end
      end

      def copyright_image
        pointsize = 16
        image.convert("-gravity southeast -pointsize #{pointsize} -fill white -annotate 0 '(c) www.caststone.com.au #{Time.now.year}'")
      end

      def popup_image
         name thumbnail('250x')
      end
      private

      def save_drawing
        #       always save the drawing - won't be changed that often.
        #       bonus: saves the height too.
        component_ids = self.base_ids + self.shaft_ids + self.column_ids + self.capital_ids + self.letterbox_ids
        self.drawing = Refinery::Caststone::Component.construct(component_ids) unless component_ids.empty?
        self.height = self.components.sum('height')
      end
    end
  end
end
