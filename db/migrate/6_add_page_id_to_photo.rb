class AddPageIdToPhoto < ActiveRecord::Migration[5.2]
  def change
    add_reference :refinery_caststone_photos, :page
  end
end
