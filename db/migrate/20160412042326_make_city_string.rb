class MakeCityString < ActiveRecord::Migration
  def change
    add_column :items, :city, :string
    remove_column :items, :city_id
  end
end
