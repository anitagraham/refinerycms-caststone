class CreateCaststoneComponentsPhotos < ActiveRecord::Migration

  def change
    create_table :refinery_caststone_assignments do |t|
      t.refences :component_id,  :photo_id

    end
    add_index(:refinery_caststone_assignments, [:component_id, :photo_id], :name => :index_component_id_photo_id)

  end

end
