# This migration comes from refinery_caststone (originally 3)
class CreateCaststonePhotos < ActiveRecord::Migration

  def up
    create_table :refinery_caststone_photos do |t|
      t.string :name
      t.string :caption
      t.integer :image_uid
      t.text    :drawing
      t.integer :product_id
      # t.integer :component_count
      # t.integer :total_component_height
      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-caststone"})
    end

    drop_table :refinery_caststone_photos

  end

end
