class AddProductTypeToSeries < ActiveRecord::Migration[5.2]
  def change
    add_column :refinery_caststone_products, :product_type, :string
  end
end
