class AddTrackidToPhoto < ActiveRecord::Migration[6.0]
  def change
    add_column :refinery_images, :tracking_id, :string
  end
end
