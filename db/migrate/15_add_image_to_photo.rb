class AddImageToPhoto < ActiveRecord::Migration[6.0]
  def change
    add_column :refinery_caststone_photos, :image_id, :reference
  end
end
