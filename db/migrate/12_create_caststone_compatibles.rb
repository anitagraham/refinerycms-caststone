class CreateCaststoneCompatibles < ActiveRecord::Migration[4.2]

  def up
    create_table :refinery_caststone_compatibles do |t|
      t.references :product
      t.references :component
      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({name: "refinerycms-caststone"})
    end

    drop_table :refinery_caststone_compatibles

  end

end
