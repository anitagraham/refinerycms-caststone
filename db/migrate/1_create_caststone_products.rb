class CreateCaststoneProducts < ActiveRecord::Migration[4.2]

  def up
    create_table :refinery_caststone_products do |t|
      t.string :name
      t.text :blurb
      t.boolean :buildable
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-caststone"})
    end

    drop_table :refinery_caststone_products

  end

end
