class AddFeaturesToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :refinery_caststone_products, :tag_line, :string
    add_column :refinery_caststone_products, :summary, :text
    add_column :refinery_caststone_products, :features, :text
    add_column :refinery_caststone_products, :measurements, :text
    add_column :refinery_caststone_products, :image, :reference
    add_column :refinery_caststone_products, :brochure, :reference
    add_column :refinery_caststone_products, :brochure_cover, :reference
  end
end
