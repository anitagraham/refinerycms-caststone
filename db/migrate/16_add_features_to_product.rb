class AddFeaturesToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :refinery_caststone_products, :features, :text
    add_column :refinery_caststone_products, :measurements, :text
  end
end
