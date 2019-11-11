class AddDrawingToSeries < ActiveRecord::Migration[5.2]
  def change
    add_column :refinery_caststone_products, :drawing_uuid, :integer
  end
end
