class AddTrackidToPhoto < ActiveRecord::Migration[6.0]
  def change
    add_column :refinery_images, :photo_number, :string
  end
end
