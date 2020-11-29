# Open the Refinery::Page model for manipulation

Refinery::Page.class_eval do
  has_many :photos, class_name: "Refinery::Caststone::Photo"
end
