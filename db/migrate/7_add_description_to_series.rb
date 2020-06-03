class AddDescriptionToSeries < ActiveRecord::Migration[5.2]
  def change
    add_column :refinery_caststone_products, :description, :text
  end
end
