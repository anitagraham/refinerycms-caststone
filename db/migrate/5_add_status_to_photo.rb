class AddStatusToPhoto < ActiveRecord::Migration
	def change
    add_column :refinery_caststone_photos, :status, :string
  end
end