class CreateCaststoneComponents < ActiveRecord::Migration[4.2]

  def up
    create_table :refinery_caststone_components do |t|
      t.string :name
      t.string :type
      t.string :note
      t.integer :height
      t.integer :drawing_id
      t.integer :product_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-caststone"})
    end

    drop_table :refinery_caststone_components

  end

end
