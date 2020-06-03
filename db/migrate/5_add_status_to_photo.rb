class AddStatusToPhoto < ActiveRecord::Migration[4.2]
	def change
    add_column :refinery_caststone_photos, :status, :string
  end
end
