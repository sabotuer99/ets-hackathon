class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :email
      t.integer :agency_id
      t.string :user_name

      t.timestamps null: false
    end
  end
end
