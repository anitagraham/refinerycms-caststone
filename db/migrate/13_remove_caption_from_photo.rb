class RemoveCaptionFromPhoto < ActiveRecord::Migration[6.0]
  def change
    remove_column :refinery_caststone_photos, :caption
  end
end
