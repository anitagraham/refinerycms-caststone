class AddPhotoNumberToPhoto < ActiveRecord::Migration[6.0]
  def change
    add_column :refinery_caststone_photos, :photo_number, :string
  end
end
