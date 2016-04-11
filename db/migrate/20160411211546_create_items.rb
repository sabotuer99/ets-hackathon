class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :description
      t.integer :agency_id
      t.string :street
      t.integer :city_id
      t.integer :state_id
      t.string :zip
      t.string :loc_lat
      t.string :loc_long

      t.timestamps null: false
    end
  end
end
