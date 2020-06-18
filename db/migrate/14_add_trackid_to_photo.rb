class AddTrackidToPhoto < ActiveRecord::Migration[6.0]
  def change
    add_column :refinery_caststone_photos, :trackid, :string
  end
end
