# Open the Refinery::Page model for manipulation

Refinery::Page.class_eval do
  attr_accessor :photos_from_cache
  has_many :photos, class_name: "Refinery::Caststone::Photo"

  def photos_from_cache
    Rails.cache.fetch([self, 'photos']) do
      photos.includes(:image, :product, :components).all
    end
  end
end

